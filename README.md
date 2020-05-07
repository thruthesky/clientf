# ClientF

* 정식명칭: ClientF
* 라이센스: MIT
* 설명: [파이어베이스 백엔드](https://github.com/thruthesky/enginf)와 플러터로 만드는 커뮤니티 앱
* 기능: 회원 로그인, 로그아웃, 가입, 수정, 비밀번호 찾기, 회원 사진 등록, 게시판 전체 기능.

## 참고 문서

* [파이어베이스 백엔드](https://github.com/thruthesky/enginf) README 참고
* [ClientF 개발자 가이드](https://github.com/thruthesky/clientf/blob/master/docs/DeveloperGuideLine.md)

## 프로토콜

* 호출 예제

```dart
(() async {
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'router',
  );
  dynamic res = await callable.call(<String, dynamic>{
  });
  print(res.data.toString());
})();
```

* 아래와 같이 호출 할 수 있습니다.
  
``` dart
AppService.functions()
    .call({'route': 'user.version'}).then((res) {
  print(res.data);
});
```



### 호출 방법

기본 호출 예제)

```
final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'router',
);
dynamic res = await callable.call(<String, dynamic>{route: '...', data: {}});
print(res.data.toString());
```
### 입력과 출력

* `route` 및 `data` 입력에 대해서는 서버 README 참고.

### 에러 예제

* EnginF 문서 참고

<!-- * `route` property 에는 `클래스명.함수명` 과 같이 기록을 한다. 예) `user.register`
* `data` property 에는 route 로 전달하는 데이터이다. 예를 들어 `user.register` 를 호출하면 `data`에는 회원 메일 주소나 비밀번호 등을 입력하면 된다.

기본 에러 예제)

* route 값에 아무런 데이터를 전달하지 않으면, `wrong-class-name` 에러가 나타난다.
* route 값에 함수명이 잘못되면 `wrong-method-name` 에러가 나타난다.

이 처럼 각 route 호출 시 관련된 에러 값을 받을 수 있다. -->

## 회원 가입

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


## 온라인 세마나

* ClientF 의 기본 폴더 및 파일 구조
* 라우팅 및 페이지 구조
* 다국어 설정
* Backend API 연결 및 프로토콜
* 회원 가입, 로그인, 수정, 로그아웃
* 회원 사진 등록


