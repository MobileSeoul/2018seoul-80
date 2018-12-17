# URI 설계

## Login

* 로그인은 카카오톡 로그인

## Places

| 메소드 | 경로               | 설명           |
| ------ | ------------------ | -------------- |
| GET    | /places            | 모든 장소 조회 |
| GET    | /places/{place_id} | 특정 장소 조회 |

## Stamps

| 메소드 | 경로                                      | 설명                 |
| ------ | ----------------------------------------- | -------------------- |
| GET    | /users/{user_id}/stamps                   | 사용자의 스탬프 조회 |
| GET    | /users/{user_id}/stamps/{stamp_id}        | 스탬프 상세 조회     |
| POST   | /users/{user_id}/places/{place_id}/stamps | 스탬프 작성          |
|        |                                           |                      |
|        |                                           |                      |

## Ranks

| 메소드 | 경로   | 설명             |
| ------ | ------ | ---------------- |
| GET    | /ranks | 실시간 순위 조회 |

## Comments

| 메소드 | 경로                                   | 설명                    |
| ------ | -------------------------------------- | ----------------------- |
| GET    | /places/{place_id}/comments            | 해당 장소의 댓글들 조회 |
| GET    | /comments/{comment_id}                 | 댓글 조회               |
| POST   | /users/{user_id}/comments/{comment_id} | 댓글 작성               |
|        |                                        |                         |
|        |                                        |                         |
|        |                                        |                         |
|        |                                        |                         |

## Users

| 메소드 | 경로             | 설명            |
| ------ | ---------------- | --------------- |
| GET    | /users/{user_id} | 마이페이지 조회 |
| PUT    | /users/{user_id} | 마이페이지 수정 |
|        |                  |                 |
|        |                  |                 |
|        |                  |                 |
|        |                  |                 |
|        |                  |                 |

