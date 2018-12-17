# Login

## 로그인

| 메소드 | 경로   | 짧은 설명 |
| ------ | ------ | --------- |
| POST   | /login | 로그인    |

### 요청 바디

```
{
	"id" : "카카오톡 로그인 한 후 반환받는 고유 ID",
	"name" : "카카오톡 로그인 한 후 반환받는 사용자 닉네임",
	"profileImagePath" : "카카오톡 로그인 한 후 반환받는 프로필 사진 경로"
}
```

### 응답 바디

#### 로그인 성공

```json
{
    "message": "login success",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MSwiaWF0IjoxNTM2ODMyMzM4LCJleHAiOjE1Mzk0MjQzMzh9.ssbA-QxKsjgmzw2q9X06F4kDefuLttwGDN8KFFCab8Q"
}
```
- token값은 Header의 Authorization에 넣어서 통신을 요청합니다.
- token값 없이 통신을 요청할 경우, 게스트 로그인으로 간주합니다.
- 로그아웃은 프론트엔드에서 token값을 지우는 것으로 대체합니다.

#### INTERNAL SERVER ERROR

```json
{
    "message": "Internel Server Error",
    "data": null
}
```
------

