# clientf


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

## 코딩 가이드라인

### 단순한 코딩

* 예를 들어, 테스트를 하거나 기타 사유로 앱 시작화면을 `회원 정보 수정` 페이지로 하는 경우,
  * 회원 정보 수정 페이지에서 백엔드로 부터 회원 정보를 불러와야 하는데,
    * `UID` 가 필요하다.
  * 하지만 `UID`는 `firebase_auth` 플러그인을 통해 `Firebase` 연결을 해야지만 상태가 설정된다.
  * 이 때 문제가 `로그인 상태`가 설정(연결 또는 갱신)되지 않은 상태 즉, `UID` 또는 `user` 객체가 null 상태에서 백엔드로 먼저 호출을 하는 것이된다.
  * `UID` 값이 없거나 설정되지 않은 상태에서 벡엔드로 호출하니 에러가 나는 것이다.
  * 그렇다고 RxDart 의 BehaviorSubject 와 같은 것으로 코딩을 하지 않는다.
* 코드가 복잡 해 지면 인생이 복잡 해 진다. 일도 제대로 안되고, 능률도 안오르고, 하기 싫고, 포기하게 되는 루저의 길을 걷게 되는 것이다.
* 해결책은 보다 간단한 Timer.run() 도 하나의 방법이 되겠다. 오직, 테스트를 위한 간단한 경우.



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


