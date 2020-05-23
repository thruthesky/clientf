# ClientF

* 임시명칭: ClientF
* 명칭설명: EngineF 의 Flutter Client 라는 뜻. Client 가 Angular 이면 ClientA 가 되고 View 이면 ClientV, React 이면 ClientR.
* 라이센스: MIT
* 설명: [파이어베이스 백엔드](https://github.com/thruthesky/enginf)와 플러터로 만드는 커뮤니티 앱
* 기능: 회원 로그인, 로그아웃, 가입, 수정, 비밀번호 찾기, 회원 사진 등록, 게시판 전체 기능.
* 본 앱은 파이어베이스를 백엔드로 사용하는 기본 커뮤니티 기능을 가지고 있습니다. 약간 수정을 하면 쇼핑몰 앱이나 회사 소개 앱 등 여러가지로 활용이 가능합니다.
  * 모든 앱에서 회원 가입 및 정보 수정을 필수라고 할 수 있습니다. 또한 최소한의 공지 사항 또는 후기 게시판 정도의 기능은 있어야 겠죠.
  * 파이어베이스를 기본으로 하기 때문에 서버 관리를 하지 않고 편하게 운영 할 수 있다.

## 참여방법

* ClientF 프로젝트에 수정 사항을 바로 업로드하는 멤버에 초대되기 전에
  * 먼저 Git Fork 를 해서 테스트 해 보시고, 소소 코드를 파악하시고, 수정 사항이 있으면 PR 을 해 주세요.
* PR 이 늘어나면, 소스 코드를 어느 정도 이해하고 있다고 판단하여 Git 프로젝트 멤버로 초대를 해 드리겠습니다.
* 소스 코드를 파악하면서 주석으로 설명을 달아주셔도 좋고, 예제와 같은 문서 작업을 해 주셔도 좋습니다.

## 참고

* [한국 플러터 커뮤니티 소개](https://docs.google.com/document/d/e/2PACX-1vTapmKIF_w575Q6ooyfGYtdRg6c5hXoA4bFOCAwh4YZyhXinExvzmcBfuz_E3cHy-4SphUDDawp4Fr8/pub)

## 개발 련련 문서

* [파이어베이스 백엔드](https://github.com/thruthesky/enginf) README 참고
* 본 프로젝트에 참여하고 싶은 분은 [ClientF 개발자 가이드](https://github.com/thruthesky/clientf/blob/master/docs/DeveloperGuideLine.md)를 보고 따라해 주시면 됩니다.
* [프로토콜 문서](https://github.com/thruthesky/clientf/blob/master/docs/Protocols.md)는 클라이언트와 백엔드 간의 통신을 설명합니다.
* EnginF 테스트 파일은 [EnginF Git Repo](https://github.com/thruthesky/enginf)에서 `**/*.spec.ts` 파일을 보면 된다.
* [EnginfF ClientF Service 테스트](https://github.com/thruthesky/enginf_clientf_service/tree/master/test)

## 설치

현재 Git repo 를 clone 또는 fork 해서 로컬 머신에서 테스트한다.

* `git clone https://github.com/thruthesky/clientf`
* `cd clientf`
* `git submodule update --init`
* `git submodule foreach git checkout master`

### iOS 설치 예제

* ios/Runner/GoogleService-Info.plist 파일을 삭제한다.
* Xcode 에서 Runner > Identity 에서 Bundle ID 를 기록한다.
* 파이어프로젝트에서 iOS 앱을 추가하고, Bundle ID 를 동일하게 기록한다.
* GoogleService-Info.plist 를 다운로드해서
  * ios/Runner/ 폴더에 저장한 다음,
  * Xcode 의 Runner > Runner 아래로 드래그해서 넣는다.
* pod 설치를 한다.
  * cd ios
  * pod install

* `Firebase Stroage` 의 folder path 를 복사해서 `lib/settings.dart` 의 `storageLink` 에 집어 넣는다. 
* 앱을 실행한다.
* 관리자 이메일로 로그인을 한다.
* 카테고리에
  * discussion 과 qna 두개를 만든다.
  * 게시판 글 쓰기를 한다.
  * 코멘트 글 쓰기를 한다.
  * 사진 업로드를 한다.
* 로그아웃을 하고,
  * 회원 가입을 한다.
  * 회원 정보 수정을 한다.
  * 회원 사진 업로드를 한다.

### Android 설치 예제

* android/app/google-services.json 을 삭제한다.
* Firebase console 에서 Android 앱을 추가하고, google-services.json 을 다운 받아
  * android/app/google-services.json 에 복사한다.






## 회원 관리

* 앱을 시작하면 `Firebase Auth` 의 `Anonymous` 로 자동 로그인을 한다. 사용자가 로그아웃을 해도 `Anonymous`로 자동 로그인을 한다.

* 로그인과 로그아웃은 `Enginef` 로 연결하지 않고 직접 `Firebase Auth`로 로그인/로그아웃을 한다.
* 다만, 회원 가입이나 회원 정보 수정과 같이 정보를 회원 정보를 업데이트하는 경우에는 Enginf 를 통해서 해야 한다.

### 회원 가입 로직

* 회원 가입과 회원 정보 수정은 같은 `register` 페이지에서 한다.

* 회원 가입을 하기 전에는 Anonymous 로 로그인 된 상태이다.
* 회원 가입 페이지에서 사진을 업로드하면
  * Anonymous 로그인을 한 상태이므로 `Firestore`에 사진을 등록 할 수 있다.
  * 실제로 가입을 하면, 업로드한 사진을 사용자 정보로 집어 넣는다.
* `Enginf` 를 통해서 가입(계정을 생성)하면, 로그인이 되지 않으므로, 별도로 로그인을 해야 한다.
  * 즉, `Enginf` 를 통해서 가입(계정을 생성 및 정보 저장)하고, 플러터에서 `Firebase Auth`로 로그인을 한다.

* 회원 정보 저장시 입력 데이터는 Map 값으로
  * `email` 과 `password` 는 `필수 속성`. 
  * `displayName`, `phoneNumber`, `photoURL` 은 이미 정해져 있는 `선택 속성`
  * 그 외 얼마든지 추가로 저장 가능하다. 이를 `추가 속성`이라 한다.

* 회원 가입을 하면 기본적으로 `Firebase Auth` 에 계정이 생성되며, `필수 속성`과 `선택 속성`이 `Firebase Auth` 에 저장되고 
  * `추가 속성`은 Firestore `user` collection 에 UID 로 그 외의 나머지 값이 저장 된다.


* 에러코드. 서버 README 참고

## State management 와 Callback

### Ping/pong 콜백

이 내용은 `flutter_engine` 으로 이동 할 것

* 글을 보여주는 `범용 Engine 위젯` A 가 있는 경우,
  * A 의 `[수정]` 버튼을 클릭하면,
    * 새로운 Router `[글 수정 페이지 B]`가 열려야한다.
    * 이 때, Router 를 이동하는 코드나 Route 를 관리하는 코드는 앱의 메인 코드에서 해야한다.
    * 위젯 A 에서 하면, 그 위젯은 특정 앱에 종속적이게 되며 범용성을 잃게 된다.
    * 이것은 `State management` 나 `Reactive` 코딩을 해도 마찬가지이다.
      * 예를 들어 `범용 공유 위젯`이 MobX 를 쓴다면 앱에서도 MobX 를 써서 글과 관련된 상태를 업데이트해야한다.
      * 그런데 만약, 개발자가 MobX 사용법을 모르거나 사용하기를 원하지 않는다면, 해당 `범용 위젯`은 더 이상 범용적이지 모하게 된다.
  * 그래서 콜백을 사용하는데,
    * B 페이지에서 위젯 A를 포함 할 때, 수정 버튼을 클릭하면 Callback 이 호출되게 한다.
      * 즉, 수정 루틴은 B 페이지에서 처리를 하는 것이다.
      * B 페이지가 처리가 끝나면 다시 위젯 A 의 Callback 으로 수정된 값 또는 결과 처리를 알려주는 것이다.

* 이 처럼 서로 콜백을 동록하여 통신하는 것을 Ping/pong 콜백이라고 한다.
* 또한 이러한 현상으로 Callback drilling 이 발생하고 Callback hell 이 나타날 조짐이 보인다.

### Callback hell 방지를 위한 State 를 전달

* Ping/pong Callback 이 필요한 이유는 `위젯 A`를 업데이트 해야하는데, 이는 `위젯 A`의 State 를 통해서 업데이트가 가능하다.
* 따라서 `위젯 A state` 를 Callback 으로 전달 해 버리고, `페이지 B`에서 필요한 처리를 하고, `위젯 A state`를 통해서 `.setState()`를 바로 호출해서 rendering 해 버린다.
* 이렇게 state 를 전달하는 방식에 대해서 확신이 없었는데, [공식 Youtube 강좌. Programatic State Management in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I) 에서 사용하고 있는 것을 확인 할 수 있었다.
* 예를 들어 `페이지 B` 에서 글 목록을 ListView 로 표시하는데, 글 하나를 수정하면 수정 된 하나에 대해서만 `state.setState(()  => {})` 하여 해당 글 위젯만 re-build 하는 것이 맞다.


* 하지만 Flutter 에서는 ListView 를 Rendering 할 때 모든 ListView 아이템을 Rendering 하는 것이 아니라, 화면에 보이는 Object tree 만 랜더링을 하므로 속도가 빠른 편이다.
  * 그래서 글 하나가 수정 될 때, 그 글 위젯의 state 를 전달하지 않고, 그냥 `페이지 B`에서 setState() 를 해서 전체 페이지를 다시 그리는 것도 하나의 방법이다.







## 로그인

* 설명은 AppModel::login() 참고

``` dart
final user = await app.login(data['email'], data['password']);
if (user == null) {
  print('Error login');
} else {
  print('success login');
}
```



### 에러 확인

* Firebase 에서 전달되어져 오는 에러 코드를 그대로 활용하고 i18n text 에도 적용한다.
  * 이 때, i18n text code 는 모두 소문자이므로 Firebase error code 도 소문자로 해 주어야 한다.

``` dart
try {
  // ...
} on PlatformException catch (e) {
  final code = e.code.toLowerCase(); // 여기 처럼 에러 코드를 소문자로 해야 한다. 이것은 언어 번역에서 사용되기 때문이다.
  if (code == ERROR_INVALID_EMAIL) {
    AppService.alert(null, t(ERROR_INVALID_EMAIL));
  }
  if (code == ERROR_USER_NOT_FOUND) {
    AppService.alert(null, t(ERROR_USER_NOT_FOUND));
  }
} 
```


## 파일(사진) 업로드 관련 코딩

* `AppStore` 클래스는 `Firestoer`에 사진을 쉽게 등록 할 수 있도록 도와 준다.
* 회원 프로필 사진, 글, 코멘트 등에서 사용 할 수 있는데, 사용 할 수 있는 범위가 꽤 넓다.
  * 이에 따라 `AppStore` 도 유연하게 되어져 있다.
* `AppStore` 는 State 로 관리하지 순수 Future 와 Callback 으로만 관리를 한다.
* 회원 사진의 경우 `photoUrl` 삭제가 안된다. `null` 값을 저장 할 수 없다. 그래서 `app.defines.dart` 에 정의된 `DELETED_PHOTO` 값을 지정하여, 사진이 삭제 되었음을 표시한다.

## 소스의 구성

* 파이어베이스 및 Enginf 설정
  * 백엔드 설치 설명서 제공
* ClientF 의 기본 폴더 및 파일 구조
* 라우팅 및 페이지 구조
* 다국어 설정
* 파이어베이스 벡엔드와 데이터 송수신 설명
* 회원 가입, 로그인, 수정, 로그아웃
* 회원 사진 등록




## 알려진 문제점

* 댓글을 작성한 직후, 작성된 댓글이 댓글 사이에 들어간다. 이 때, 댓글 트리 구조가 유지되지만, 작성된 댓글 1개에 한해서만 시간 순서가 바뀐다. 
  * 부모 댓글 바로 아래로 달리는 것인데, 큰 문제가 없다.
  * 리프레시하면 시간 순서로 바뀐다.
  * 이 문제는 ... 댓글을 작성한 후, 해당 댓글이 댓글 트리의 아래 부분에 추가되면, 화면에 보여지지 않기 때문에 어쩔 수 없이 해 놓은 것으로, 버그가아니다.
  * 특별한 문제가 없으면 이 상태로 유지한다.

