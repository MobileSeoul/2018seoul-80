# myPage

## 마이페이지 조회

| 메소드 | 경로    | 짧은 설명       |
| ------ | ------- | --------------- |
| GET    | /mypage | 마이페이지 조회 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 응답 바디

#### 전체 스탬프 조회 성공

```json
{
    "message": "Successful Get User Data",
    "data": {
        "name": "배다슬",
        "picture": "profileImagePath",
        "stampCount": 1,
        "lastStampDate": "2018-09-13T10:06:36.000Z"
    }
}
```
#### 없는 사용자일 경우

```json
{
    "message": "Not Found User Data",
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
## 내가 적립한 스탬프 조회

| 메소드 | 경로               | 짧은 설명          |
| ------ | ------------------ | ------------------ |
| GET    | /stamps | 장소의 스탬프 조회 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 응답 바디

#### 스탬프 조회 성공

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
                "stamp_status": 1
            },
            {
                "place_id": 2,
                "place_name": "문화비축기지",
                "place_address": "서울시 마포구 증산로 87",
                "place_star": 1,
                "place_pic": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
                "stamp_status": 0
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
                "stamp_status": 0
            }
        ]
    }
}
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
## 마이 페이지 수정

| 메소드 | 경로    | 짧은 설명    |
| ------ | ------- | ------------ |
| PUT    | /mypage | 내 정보 수정 |

### 요청 헤더

```
Content-Type: application/json
Authorization: token값
```

### 요청 바디

* 값을 보내지 않으면 기존의 값으로 대체

```
{
    "name": "이름",
    "picture": "사진 데이터"
}
```

### 응답 바디

#### 마이 페이지 수정 성공

```json
{
    "message": "Successful Update User",
    "data": null
}
```
#### 마이 페이지 수정 실패

```json
{
    "message": "Fail Update User",
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