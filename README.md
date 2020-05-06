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



### 기본 호출 및 에러 예제

기본 호출 예제)

```
final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'router',
);
dynamic res = await callable.call(<String, dynamic>{route: '...', data: {}});
print(res.data.toString());
```

* `route` property 에는 `클래스명.함수명` 과 같이 기록을 한다. 예) `user.register`
* `data` property 에는 route 로 전달하는 데이터이다. 예를 들어 `user.register` 를 호출하면 `data`에는 회원 메일 주소나 비밀번호 등을 입력하면 된다.

기본 에러 예제)

* route 값에 아무런 데이터를 전달하지 않으면, `wrong-class-name` 에러가 나타난다.
* route 값에 함수명이 잘못되면 `wrong-method-name` 에러가 나타난다.

이 처럼 각 route 호출 시 관련된 에러 값을 받을 수 있다.


### 회원 관리

#### 회원 가입

* route: user.register
* data 는 기본적으로 email 과 password 는 필수. 나머지는 얼마든지 추가로 저장 가능.
* 회원 가입을 하면 기본적으로 Auth 에 계정이 생성되며,
* Firestore `user` collection 에 UID 로 추가된 값이 저장 됨


* 에러코드

코드 | 설명
--- | ---
input-data-is-not-provided | 회원 가입 정보를 전달하지 않은 경우
email-is-not-provided | 이메일 주소를 입력하지 않은 경우
password-is-not-provided | 비밀번호를 입력하지 않은 경우
auth/email-already-exists | 동일한 메일 주소가 이미 가입되어져 있는 경우

