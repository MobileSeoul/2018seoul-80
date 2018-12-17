# Comments

## 댓글 상세 조회

| 메소드 | 경로                    | 짧은 설명      |
| ------ | ----------------------- | -------------- |
| GET    | /comments/{comment_idx} | 댓글 상세 조회 |

### 응답 바디

#### 댓글 상세 조회 성공

```json
{
    "message": "Successful Get Comment Data",
    "data": [
        {
            "writer_name": "김다은",
            "comment_id": 2,
            "writer_id": 1,
            "comment_star": 1,
            "comment_date": "0000-00-00 00:00:00",
            "comment_comment": "덕수궁 돌담길 너무 좋아용",
            "place_id": 1,
            "comment_pic1": null,
            "comment_pic2": null,
            "comment_pic3": null,
            "comment_pic4": null
        }
    ]
}
```
#### 댓글 상세 조회 실패

```json
{
    "message": "Not Found Comment Data",
    "data": null
}
```

#### INTERNAL SERVER ERROR

```json
{
    "message": "Internel Server Error",
    "data": null
}
```
------
## 댓글 작성

| 메소드 | 경로      | 짧은 설명 |
| ------ | --------- | --------- |
| POST   | /comments | 댓글 작성 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 요청 바디

* 사진은 총 4장까지 가능
* 사진의 Key 값은 pictures로 동일

```
{
	"place_id": "장소 ID",
	"star": "평점",
	"comments": "댓글 내용",
	"pictures" : ["사진1", "사진2", "사진3", "사진4"]
}
```

### 응답 바디

#### 댓글 작성 성공

```json
{
    "message": "Successful Post Comment",
    "data": null
}
```
#### 이미 댓글을 작성했을 경우

```json
{
    "message": "Already Post Comment",
    "data": null
}
```
#### 인가 실패

```json
{
    "message": "access denied",
    "data": null
}
```
#### INTERNAL SERVER ERROR

```json
{
    "message": "Internel Server Error",
    "data": null
}
```
------
## 댓글 삭제

| 메소드 | 경로                   | 짧은 설명 |
| ------ | ---------------------- | --------- |
| DELETE | /comments/{comment_id} | 댓글 삭제 |

* 내가 작성한 댓글만 삭제 가능
* 남이 작성한 댓글 삭제 요청시 404 반환

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 응답 바디

#### 댓글 삭제성공

```json
{
    "message": "Successful Delete Comment",
    "data": null
}
```
#### 댓글 삭제 실패

```json
{
    "message": "Fail Delete Comment",
    "data": null
}
```
#### 인가 실패

```json
{
    "message": "access denied",
    "data": null
}
```
#### INTERNAL SERVER ERROR

```json
{
    "message": "Internel Server Error",
    "data": null
}
```
------