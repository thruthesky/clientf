# ClientF

* 정식명칭: ClientF
* 명칭설명: EngineF 의 Flutter Client 라는 뜻. Client 가 Angular 이면 ClientA 가 되고 View 이면 ClientV, React 이면 ClientR.
* 라이센스: MIT
* 설명: [파이어베이스 백엔드](https://github.com/thruthesky/enginf)와 플러터로 만드는 커뮤니티 앱
* 기능: 회원 로그인, 로그아웃, 가입, 수정, 비밀번호 찾기, 회원 사진 등록, 게시판 전체 기능.

## 개발 련련 문서

* [파이어베이스 백엔드](https://github.com/thruthesky/enginf) README 참고
* 본 프로젝트에 참여하고 싶은 분은 [ClientF 개발자 가이드](https://github.com/thruthesky/clientf/blob/master/docs/DeveloperGuideLine.md)를 보고 따라해 주시면 됩니다.
* [프로토콜 문서](https://github.com/thruthesky/clientf/blob/master/docs/Protocols.md)는 클라이언트와 백엔드 간의 통신을 설명합니다.
* EnginF 테스트 파일은 [EnginF Git Repo](https://github.com/thruthesky/enginf)에서 `**/*.spec.ts` 파일을 보면 된다.
* [EnginfF ClientF Service 테스트](https://github.com/thruthesky/enginf_clientf_service/tree/master/test)

## 설치

* `git clone `
* `git submodule update --init`

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


## 온라인 세미나 진행

* 파이어베이스 및 백엔드 설정
  * 백엔드 설치 설명서 제공
* ClientF 의 기본 폴더 및 파일 구조
* 라우팅 및 페이지 구조
* 다국어 설정
* 파이어베이스 벡엔드와 데이터 송수신 설명
* 회원 가입, 로그인, 수정, 로그아웃
* 회원 사진 등록


