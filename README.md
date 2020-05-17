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

## 개발 련련 문서

* [파이어베이스 백엔드](https://github.com/thruthesky/enginf) README 참고
* 본 프로젝트에 참여하고 싶은 분은 [ClientF 개발자 가이드](https://github.com/thruthesky/clientf/blob/master/docs/DeveloperGuideLine.md)를 보고 따라해 주시면 됩니다.
* [프로토콜 문서](https://github.com/thruthesky/clientf/blob/master/docs/Protocols.md)는 클라이언트와 백엔드 간의 통신을 설명합니다.
* EnginF 테스트 파일은 [EnginF Git Repo](https://github.com/thruthesky/enginf)에서 `**/*.spec.ts` 파일을 보면 된다.
* [EnginfF ClientF Service 테스트](https://github.com/thruthesky/enginf_clientf_service/tree/master/test)

## 설치

* `git clone https://github.com/thruthesky/clientf`
* `cd clientf`
* `git submodule update --init`

### iOS 설치 예제

* ios/GoogleService-Info.plist 파일을 삭제한다.
* Xcode 에서 Runner > Identity 에서 Bundle ID 를 기록한다.
* 파이어프로젝트에서 iOS 앱을 추가하고, Bundle ID 를 동일하게 기록한다.
* GoogleService-Info.plist 를 다운로드해서 Xcode 의 Runner > Runner 아래로 드래그해서 넣는다.
* 끝! 앱을 실행하고, 회원가입 한 후, Auth 에 추가되는지 본다.




## 회원 관리

@todo: 개발가이드로 이동

* 정보 업데이트가 필요 없는, 회원 로그인, 로그아웃은 EnginF 와 상관없이 그냥 `firebase_auth` 플러그인으로 하면 된다.
* 회원 가입이나 수정과 같이 정보를 업데이트하는 경우, Enginf 를 통해서 하면 된다.



### 회원 가입 로직

* 회원 가입을 하면 로그인 세션이 연결되고 유지되어야 한다.
  * Functions 를 통해서 계정을 생성하면, 로그인 세션이 생성되지 않는다.
  * 즉, Functions 를 통해서 계정을 생성하고, 플러터에서 로그인을 한다.

* route: user.register
* data 는 기본적으로 email 과 password 는 필수. 나머지는 얼마든지 추가로 저장 가능.
* 회원 가입을 하면 기본적으로 Auth 에 계정이 생성되며,
* Firestore `user` collection 에 UID 로 추가된 값이 저장 됨


* 에러코드. 서버 README 참고
* 
<!-- 
코드 | 설명
--- | ---
input-data-is-not-provided | 회원 가입 정보를 전달하지 않은 경우
email-is-not-provided | 이메일 주소를 입력하지 않은 경우
password-is-not-provided | 비밀번호를 입력하지 않은 경우
auth/email-already-exists | 동일한 메일 주소가 이미 가입되어져 있는 경우 -->

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

* 파일(사진)은 Firestore 에 등록하고 그 URL 을 각 collection/document 에 저장한다.
* URL 저장과 삭제는 `addUrl()`, `removeUrl()`을 사용한다.
* 글 (또는 코멘트 및 기타 collection) 수정을 할 때에는 해당 document 에 이미 `urls` 속성이 있어서 document 에 값을 바로 저장하고, 화면에 보열 줄 때에도 `urls` 속성을 참고해서 보여주면 된다.
* 하지만 글 (또는 코멘트 및 기타 collection)을 작성할 때에는 `urls` 속성 뿐만아니라 document 자체가 존재하지 않는다.
* 그래서 다음과 같이 일관적인 코딩을 모든 collection/document 에 적용한다.

* 코멘트 예제
  * 코멘트 생성(또는 수정) 박스를 `FirestoreModel` 로 state 관리한다.
  * 코멘트를 생성 할 때 현재 코멘트를 담는 변수가 null 이면, `EnginComment()`와 같이 해서 현재 코멘트를 담는 변수에 넣어준다.
    * 그리고 코멘트 생성 관련 모든 정보를 현재 코멘트 변수에 넣고 관리하다가 저장 버튼을 클릭하면 백엔드로 전송을 한다.

* 파일(사진) 화면에 표시
  * `DisplayUploadedImages` 에서하는데, `FirestoreModel.doc.files` 를 쓰면, 굳이 현재 위젯이 user, post, comment 인지에 따라서 별도의 코딩을 할 필요 없이, Dependency Inject 으로 처리 할 수 있다.
  



## 온라인 세미나 진행

* 파이어베이스 및 백엔드 설정
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



## 코멘트 댓글 작성시 state


* 문제점
  * ObjectRender Tree 에서 Element 가 사라지면 State Object 도 같이 사라진다.
  * 글 목록 State 전체가 날라가버려서, 코멘트 Form 을 여는 플래그 변수 마저 같이 날라가, 작정 중인 Form 의 내용이 모두 사라진다.
  * 그래서 댓글 작성하다가 저장하지 않고, 스크롤 다운 하면 수정 중이던 state 가 날라가고, 스크롤 업해서 다시 보려면, state 가 없으므로, commet-box 자체가 닫겨져 있거나 내용이 없게 된다.
* 수정도 마찬가지이다. 수정하다가 스크롤 다운하고 업하면, 수정된 내용이 사라진다.
* ListView 를 사용하여 꼭 필요한 만큼만 화면에 보여주는 것이 성능 향상에 좋다.
  * 따라서 렌더링 화면에서 사라지는 Item 을 KeepAlive 로 하면, 전체 Istem 위젯이 살아있기 때문에 ListView 를 사용해서 서능향상을 시키려는 것이 무용지물이 된다.

 //// 여기서 부터
* 해결책
  * 하나의 글에서 한개의 코멘트 FORM 을 열 수 있다. 즉, 글이 10개면 총 10개의 코멘트 FORM 열 수 있다.
  * 생성 또는 수정하려는 버튼을 클릭 할 때, 임시 코멘트 state 를 post.tempComment 에 보관한다.
    * 이 때, 부모 commentId 를 지정해야 스크롤 후, 다시 렌더링 할 때, 어느 위치에 코멘트 FORM 열어야하는지 알 수 있다.
  * 저장 버튼을 클릭하지 않으면 서버에 저장되지 않으므로 화면에만 보이는데 상관이 없다.

