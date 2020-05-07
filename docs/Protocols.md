# ClientF 프로토콜



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
