# Places

## 장소 조회

| 메소드 | 경로    | 짧은 설명      |
| ------ | ------- | -------------- |
| GET    | /places | 모든 장소 조회 |

### 응답 바디

#### 모든 장소 조회 성공

```json
{
    "message": "Successful Get Places Data",
    "data": [
        {
            "place_id": 1,
            "place_name": "덕수궁돌담길",
            "place_address": "서울시 중구 정동",
            "place_content": "60년 만에 서울 시민의 품으로 돌아왔네요. 오랜 시간 영국 대사관의 소유였던 이 길, 이젠 동양과 서양의 미가 섞여 서울 시내 돌담길의 역대급 매력포텐이 터지다!",
            "place_category": "",
            "place_star": 1,
            "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg"
        },
        {
            "place_id": 2,
            "place_name": "문화비축기지",
            "place_address": "서울시 마포구 증산로 87",
            "place_content": "",
            "place_category": "",
            "place_star": 1,
            "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg"
        },
        {
        	"중간생략..."  
        },
        {
            "place_id": 20,
            "place_name": "다시 세운",
            "place_address": "서울시 종로구 장사동",
            "place_content": "",
            "place_category": "",
            "place_star": 5,
            "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg"
        }
    ]
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
## 장소 세부 조회

| 메소드 | 경로               | 짧은 설명 |
| ------ | ------------------ | --------- |
| GET    | /places/{place_id} | 장소 조회 |

### 응답 바디

#### 장소 세부 조회 성공

```json
{
    "message": "Successful Get Stamp Status Data",
    "data": {
        "place_id": 1,
        "place_name": "덕수궁돌담길",
        "place_address": "서울시 중구 정동",
        "place_content": "60년 만에 서울 시민의 품으로 돌아왔네요. 오랜 시간 영국 대사관의 소유였던 이 길, 이젠 동양과 서양의 미가 섞여 서울 시내 돌담길의 역대급 매력포텐이 터지다!",
        "place_category": "",
        "place_star": 1,
        "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
        "commentCount": 10
    }
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
## 장소의 댓글들 조회

| 메소드 | 경로                        | 짧은 설명          |
| ------ | --------------------------- | ------------------ |
| GET    | /places/{place_id}/comments | 장소의 댓글들 조회 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값(존재하지 않으면 게스트 로그인으로 간주)
```

* 로그인 했을 경우
  * 스탬프를 찍지 않았을 경우 스탬프 찍어야 한다는 메시지 표시
  * 스탬프는 찍었지만 평점을 남기지 않았을 경우 평점을 남겨야 한다는 메시지 표시
  * 스탬프도 찍었고, 평점도 남겼을 경우 내가 작성한 평점 표시 
* 로그인 하지 않았을 경우
  * 로그인 해야만 스탬프, 평점 찍기 가능

### 응답 바디

#### 장소 세부 조회 성공

```json
{
    "message": "Successful Get Comment List Data",
    "data": {
        "message": "로그인 해주세요. / ~님 평가해 주세요. / ~님 평가해 주세요.",
        "status": "로그인 해주세요. / 스탬프를 먼저 찎어주세요. / 별점을 평가해주세요",
        "myComment": "null / 내가 작성한 댓글",
        "comments": [
            {
                "writer_name": "writer_name 05",
                "comment_id": 27,
                "writer_id": 10,
                "comment_star": 2,
                "comment_date": "0000-00-00 00:00:00",
                "comment_comment": "덕수궁 돌담길 너무 좋아용",
                "place_id": 1,
                "comment_pic1": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic2": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic3": null,
                "comment_pic4": null
            },
            {
                "writer_name": "writer_name 04",
                "comment_id": 26,
                "writer_id": 9,
                "comment_star": 2,
                "comment_date": "0000-00-00 00:00:00",
                "comment_comment": "덕수궁 돌담길 너무 좋아용",
                "place_id": 1,
                "comment_pic1": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic2": null,
                "comment_pic3": null,
                "comment_pic4": null
            },
            {
              	"중간 생략..."  
            },
            {
                "writer_name": "writer_name 01",
                "comment_id": 2,
                "writer_id": 1,
                "comment_star": 1,
                "comment_date": "0000-00-00 00:00:00",
                "comment_comment": "덕수궁 돌담길 너무 좋아용",
                "place_id": 1,
                "comment_pic1": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic2": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic3": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "comment_pic4": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg"
            }
        ]
    }
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