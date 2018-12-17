# Stamps

## 전체 스탬프 조회

| 메소드 | 경로    | 짧은 설명        |
| ------ | ------- | ---------------- |
| GET    | /stamps | 전체 스탬프 조회 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값(존재하지 않으면 게스트 로그인으로 간주)
```

### 응답 바디

#### 전체 스탬프 조회 성공

```json
{
    "message": "Successful Get Stamp Status Data",
    "data": {
        "status": "배다슬",
        "place": [
            {
                "place_id": 1,
                "place_name": "덕수궁돌담길",
                "place_address": "서울시 중구 정동",
                "place_star": 1,
                "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "stamp_status": 1,
                "stamp_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/stamp_1.png"
            },
            {
                "place_id": 2,
                "place_name": "문화비축기지",
                "place_address": "서울시 마포구 증산로 87",
                "place_star": 1,
                "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "stamp_status": 1,
                "stamp_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/stamp_2.png"
            },
            {
              	"중간 생략..."  
            },
            {
                "place_id": 20,
                "place_name": "다시 세운",
                "place_address": "서울시 종로구 장사동",
                "place_star": 5,
                "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "stamp_status": 0,
                "stamp_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/stamp_20.png"
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
## 스탬프 조회

| 메소드 | 경로               | 짧은 설명          |
| ------ | ------------------ | ------------------ |
| GET    | /stamps/{place_id} | 장소의 스탬프 조회 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 응답 바디

#### 스탬프 조회 성공

```json
{
    "message": "Successful Get Stamp Data",
    "data": {
        "place_id": 1,
        "place_name": "덕수궁돌담길",
        "place_category": "역사 문화",
        "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
        "stamp_date": "2018-09-13T10:06:36.000Z",
        "stamp_status": 1,
        "stamp_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/stamp_1.png",
        "rank": 18,
        "status": "스탬프를 찍었습니다."
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
#### 인가 실패

```json
{
    "message": "access denied",
    "data": null
}
```
------
## 스탬프 적립

| 메소드 | 경로               | 짧은 설명          |
| ------ | ------------------ | ------------------ |
| POST   | /stamps/{place_id} | 장소의 스탬프 적립 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 응답 바디

#### 스탬프 적립 성공

```json
{
    "message": "Successful Get Stamp Data",
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
#### 인가 실패

```json
{
    "message": "access denied",
    "data": null
}
```
------