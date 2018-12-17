# Ranks

## 순위 조회

| 메소드 | 경로   | 짧은 설명      |
| ------ | ------ | -------------- |
| GET    | /ranks | 장소 순위 조회 |

### 응답 바디

#### 순위 조회 성공

* 동점일 경우 가나다 순으로 표시

```json
{
    "message": "Successful Get Place Rank Data",
    "data": [
        {
            "place_id": 20,
            "place_name": "다시 세운",
            "place_star": 5,
            "place_category": "도시 건축"
        },
        {
            "place_id": 19,
            "place_name": "도시건축비엔날레",
            "place_star": 5,
            "place_category": "도시 건축"
        },
        {
            "place_id": 18,
            "place_name": "돈의문 박물관마을",
            "place_star": 5,
            "place_category": "도시 건축"
        },
        {
            "place_id": 17,
            "place_name": "서울로 7017",
            "place_star": 5,
            "place_category": "역사 문화"
        },
        {
            "place_id": 15,
            "place_name": "서울시립과학관",
            "place_star": 5,
            "place_category": "과학 경제"
        },
        {
            "place_id": 16,
            "place_name": "서울창업허브",
            "place_star": 5,
            "place_category": "과학 경제"
        },
        {
            "place_id": 14,
            "place_name": "서울혁신파크",
            "place_star": 5,
            "place_category": "과학 경제"
        },
        {
            "place_id": 11,
            "place_name": "서울바이오허브",
            "place_star": 4,
            "place_category": "과학 경제"
        },
        {
            "place_id": 13,
            "place_name": "양재 R&CD 혁신허브",
            "place_star": 4,
            "place_category": "과학 경제"
        },
        {
            "place_id": 12,
            "place_name": "장안평 자동차산업 종합정보센터",
            "place_star": 4,
            "place_category": "과학 경제"
        },
        {
            "place_id": 9,
            "place_name": "새활용플라자",
            "place_star": 3,
            "place_category": "과학 경제"
        },
        {
            "place_id": 8,
            "place_name": "서울식물원",
            "place_star": 3,
            "place_category": "역사 문화"
        },
        {
            "place_id": 10,
            "place_name": "하수도과학관",
            "place_star": 3,
            "place_category": "과학 경제"
        },
        {
            "place_id": 6,
            "place_name": "50플러스 남부캠퍼스",
            "place_star": 2,
            "place_category": "역사 문화"
        },
        {
            "place_id": 4,
            "place_name": "경춘선 공원",
            "place_star": 2,
            "place_category": "역사 문화"
        },
        {
            "place_id": 5,
            "place_name": "봉제역사관 이음피움",
            "place_star": 2,
            "place_category": "역사 문화"
        },
        {
            "place_id": 7,
            "place_name": "한강 함상공원",
            "place_star": 2,
            "place_category": "역사 문화"
        },
        {
            "place_id": 1,
            "place_name": "덕수궁돌담길",
            "place_star": 1,
            "place_category": "역사 문화"
        },
        {
            "place_id": 2,
            "place_name": "문화비축기지",
            "place_star": 1,
            "place_category": "역사 문화"
        },
        {
            "place_id": 3,
            "place_name": "여의도 지하 비밀벙커",
            "place_star": 1,
            "place_category": "역사 문화"
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

