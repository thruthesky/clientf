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

## 공통 사항

* 회원 정보와 게시글 저장 등에서 필수 속성과 기본 속성이 있다.
  * NoSQL 의 특성상 얼마든지 자유롭게 속성을 더 추가 할 수 있다.
    * 예를 들어 회원 정보에 adress, zipcode 등 얼마든지 추가적인 값을 저장 할 수 있다.
  * 게시글이나 코멘트 역시 마찬가지로 필 속성과 기본 속성외에 얼마든지 더 많이 추가 할 수 있다.

* 모든 부분에서 에러가 나면 throw 하는데,
  * `error` 속성이 true 이며
  * `code` 에 에러 코드
  * `message` 에 추가 설명이 들어가 있다.

* 엔드 소스에서 `post/**.spect.ts` 를 참고하면 실제로 클라이언트가 어떻게 백엔드로 값을 주고 받는지에 대한 많은 예제를 볼 수 있다.

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


## 게시판 관련

### 게시글 공통

* 게시글 생성을 하면 `createdAt` 속성에 생성된 시간이 milliseconds 로 들어간다.
* 게시글 업데이트를 하면 `updatedAt` 속성에 마지막으로 업데이된 시간이 milliseconds 로 들어간다.
* 게시글 삭제를 하면 `deletedAt` 속성에 삭제한 시간이 milliseconds 로 들어간다.
* 에러가 있으면 throw 한다.

### 게시글 생성

* 사용자 로그인 필수
* `categories` 속성 필수.
  * 카테고리는 실제로 생성되어 존재하는 것이어야 하며, 문자 배열로 전달해야 한다.
  * 예) [ 'categoryA', 'categoryB' ]
* `title`, `content`는 기본 속성.
  * 제목은 반드시 `title` 속성에 넣어야 한다.
  * 내용은 `content` 속성에 넣어야 한다.
* 그 외 원하는 값을 얼마든지 저장 할 수 있다.


### 게시글 수정

* 사용자 로그인 필수
* `id` 속성 필수. 게시글 도큐먼트 아이디
* 카테고리를 변경하고자 하는 경우, `categories` 속성에 새로운 카테고리를 배열로 전송
* 제목을 수정하고자 하는 경우 `title` 속성에 넣어 전송
* 내용을 수정하고자 하는 경우 `content` 속성에 넣어 전송


### 게시글 삭제

* 사용자 로그인 필수
* 입력이 객체가 아닌 문자열로서 게시글 도큐먼트 ID 를 전달해야 한다.
* 삭제가 올바로 되면, 삭제된 도큐먼트를 리턴한다.
  * 참고로 도큐먼트를 실제로 삭제하는 것이 아니라,
    글 제목과 내용이 `post-title-deleted`, `post-content-deleted`로 변경해서 저장한다.


### 게시글 목록

* 각 글은 하나의 도큐먼트로서 도큐먼트 id 를 가지고 있다.
* `categories` 는 문자열 배열로서 검색 할 카테고리 목록을 가지고 있다.
  * 예) { 'categories': ['categoryA', 'categoryB'] }
* `limit` 은 한 페이지에 가져올 글 수를 말하는 것으로 기본 값으 20이다.
* `orderBy` 는 검색 할 속성을 지정하는 것으로 기본 값은 `createdAt` 속성이다.
* `orderBySort`는 `asc` 또는 `desc`를 지정하는 것으로 기본 값은 `desc` 이다.
* `includeComments` 는 게시글 목록을 가져 올 때, 코멘트들을 같이 가져 올 것인지 지정하는 것으로 기본 값은 false 이다.
* 다음 페이지의 글을 읽기 위해서는 `startAfter`에 현재 페이지의 글들 중 마지막 글의 `createdAt` 값을 전달하면 된다.

* 참고로 `post.spec.ts` & `post.list.spec.ts` 테스트 파일에 검색과 관련된 예제를 볼 수 있다.

예제 )
```
{
  categories: [ 'qna' ],
  limit: 10,
  includeComments: true
}
```


### 코멘트 생성

* 로그인 필수
* `postId` 는 게시글 아이디. 필수.
* `content` 는 코멘트 내용. 선택
* `parentId` 는 코멘트의 코멘트를 작성하는 경우, 부모 코멘트의 ID. 게시글 바로 밑에 코멘트를 다는 경우는 선택 사항.

### 코멘트 수정

* 로그인 필수
* `id` 에는 코멘트 도큐먼트 ID. 필수.
* `content` 에는 코멘트 내용. 선택.

### 코멘트 삭제

* 로그인 필수
* `id` 에는 코멘트 도큐먼트 ID. 필수.
* 삭제가 올바로 되면, 삭제된 도큐먼트를 리턴한다.
  * 참고로 도큐먼트를 실제로 삭제하는 것이 아니라,
    코멘트 내용이 `comment-content-deleted`로 변경해서 저장한다.


