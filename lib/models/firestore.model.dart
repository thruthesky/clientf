import 'package:clientf/services/app.service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:clientf/services/app.i18n.dart';

/// FirestoreModel 에서는 사진을 찍어 올리고, 삭제 등 전반 적인 관리를 한다.
///
///
/// 사진을 카메라로 찍거나 갤러리에서 가져와서 Firestore 에 업로드하고 URL 업로드된 이미지의 URL 을 리턴함,
/// 업로드한 파일을 배열로 보관하고 삭제를 할 수 있는 기능을 제공한다.
/// 즉,  파일 업로드에 대한 전반적인 기능을 담당하는 모델이다.s
///
/// 전체 앱에 ChangeNotifierProvider 를 하지 말고 꼭 필요한 곳에서만 한다.
/// 앱에서 업로드 버튼을 클릭하면 `pickImage()` 를 호출하면 되고, 업로드 중 그래프를 보여주려면 업로드 관련 속성을 사용하면 된다.
///
/// * image_picker 플러그인 설정
/// * firebase_firestore 플러그인 설정
/// * Firebase 콘솔에서 해당 프로젝트의 Firestore 생성 및 적절한 권한 설정
///
class FirestoreModel extends ChangeNotifier {
  StorageUploadTask uploadTask;
  double uploadPercentage = 0;

  var doc;
  // var col;

  FirestoreModel(this.doc);

  // [urls] 에 저장을 하면 안되고, 코멘트에 바로 저장을 해야 한다. 그리고 서버에도 같이 저장을 해야 한다.
  // List<String> urls = [];

  /// 사진을 선택한다.
  ///
  /// * 카메라로 부터 사진을 직거나 갤러리로 부터 사진을 가져 올 수 있다.
  /// * permission_handler 플러그인으로 권한 검사를 한다.
  ///
  ///
  /// ``` dart
  ///   var image = await pickImage(
  ///       context,
  ///       index,
  ///       maxWidth: 640,
  ///       imageQuality: 80,
  ///    );
  /// ```
  ///
  ///
  ///
  Future<String> pickAndUploadImage(
    context,
    num sourceIdx, {
    double maxWidth = 1024,
    int imageQuality = 85,
  }) async {
    File file;
    const source = [ImageSource.camera, ImageSource.gallery];
    const permissionGroups = [Permission.contacts, Permission.photos];

    /// 권한 검사
    bool haveAccess = await requestPermission(permissionGroups[sourceIdx]);

    /// 권한이 있는가?
    if (haveAccess) {
      file = await ImagePicker.pickImage(
        source: source[sourceIdx],
        maxWidth: maxWidth,
        imageQuality: imageQuality,
      );

      print('got file: $file');
      if (file != null) {
        file = await compressAndGetImage(file);

        return await upload(file);
      }
    } else {
      /// 권한이 없으면 알림을 한다.
      /// 참고로 Android 에서는 항상 권한이 허용되어져 있다. 그래서 iOS 에서만 알림을 표시해도 된다.
      AppService.alert(null, t('no access to camera'));
    }

    return null;

    // return file;
  }

  /// `check permission` for certain device function access
  ///
  ///
  Future<bool> requestPermission(Permission permission) async {
    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      return false;
    }
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      return true;
    } else {
      return false;
    }
  }

  /// compress file and returns it.
  /// also fixing orientation issue when taking images via camera.
  Future<File> compressAndGetImage(File image) async {
    if (image == null) return null;
    var fileAsBytes = await image.readAsBytes();
    await image.delete();
    final compressedImageBytes =
        await FlutterImageCompress.compressWithList(fileAsBytes);
    await image.writeAsBytes(compressedImageBytes);
    return image;
  }

  /// Starts an upload task
  Future<String> upload(File file) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://enginf-856e7.appspot.com');

    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.jpg';

    print(filePath);
    print(file);
    uploadTask = _storage.ref().child(filePath).putFile(file);
    uploadPercentage = 0;

    uploadTask.events.listen((event) {
      uploadPercentage = 100 *
          (event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble());
      print(uploadPercentage);

      // 
      notifyListeners();

      // var event = snapshot?.data?.snapshot;
      // if (event?.error != null) {
      //   print('error ----->: ${event.error}');
      // }

      // double progressPercent =
      //     event != null ? event.bytesTransferred / event.totalByteCount : 0;
    });

    await uploadTask.onComplete;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(filePath);

    var _uploadedUrl = await storageReference.getDownloadURL();

    print('File Uploaded: $_uploadedUrl');

    // urls.add(_uploadedUrl);

    /// 도큐먼트의 [urls] 속성에 업로드한 사진 URL을 추가한다.
    doc.urls.add(_uploadedUrl);

    print('-----> doc.urls: ${doc.urls}');

    notifyListeners();
    return _uploadedUrl;
  }
}
