"""
csv2json.py

csv 파일을 json으로 변환한다.

- 사용 방법
    python csv2json.py raw_database.csv

- 소스 csv 파일 형식
    id,메뉴 이름,휴대성,사먹? 직접?,(단백질) 주재료,유니크 포인트,담당자
    40949894-896c-4a62-acf0-9b69214601c9,닭강정,휴대 쉬움,사먹기가 편한,닭고기/오리고기,"바삭바삭, 달콤한 맛을 느낄 수 있어요",민볼
    db7a9345-97b9-498e-b6ed-45b22eefe8c9,닭다리살 오븐구이,휴대 쉬움,사먹기가 편한,닭고기/오리고기,"겉은 바삭하고, 속은 촉촉하고 부드러워 입안에서 육즙이 풍부하게 퍼져요.",""
    abe56bd0-a0c0-4127-b2ac-d861b05616ef,닭가슴살 스틱,휴대 쉬움,사먹기가 편한,닭고기/오리고기,간편하게 단백질을 섭취하기 용이해요.,""

    "휴대성" 컬럼의 값은 다음 두 문자열 중 하나여야 한다.
    - 휴대 쉬움
    - 휴대 어려움

    "사먹? 직접?" 컬럼의 값은 다음 두 문자열 중 하나여야 한다.
    - 휴대 쉬움
    - 사먹기가 편한

    "(단백질) 주재료" 컬럼의 값은 다음 네 문자열 중 하나여야 한다.
    - "소고기/돼지고기"
    - "닭고기/오리고기"
    - "생선/해산물"
    - "콩·두부·계란"

- 결과 json 파일 형식
    [
        {
            "id": "40949894-896c-4a62-acf0-9b69214601c9",
            "title": "닭강정",
            "uniquePoint": "바삭바삭, 달콤한 맛을 느낄 수 있어요",
            "attributes": {
                "isPortable": true,
                "isCookable": false,
                "mainIngredient": "닭고기/오리고기"
            },
            "author": "민볼"
        }
    ]
"""

import csv
import sys
import json

def main():
    if len(sys.argv) != 2:
        print("usage: python csv2json.py raw_database.csv")
        sys.exit(1)

    input_file_path = sys.argv[1]

    data = read_csv(input_file_path)
    write_json(data, change_file_extension(input_file_path))

def change_file_extension(original_path: str, new_extension: str = "json") -> str:
    chunks = original_path.split(".")
    return ".".join(chunks[0:-1]) + f".{new_extension}"


def read_csv(file_path: str) -> list[dict]:
    print("source file path : " + file_path)

    menuList = []

    with open(file_path, 'r') as file:
        csv_reader = csv.reader(file)
        for (idx, row) in enumerate(csv_reader):
            if idx == 0:
                continue

            if row[1] == "": # 메뉴명이 공백이면 건너뛴다
                continue

            menuList.append({
                "id": row[0],
                "title": row[1],
                "uniquePoint": row[5],
                "attributes": {
                    "isPortable": row[2] == "휴대 쉬움",
                    "isCookable": row[3] == "직접 준비하기 쉬운",
                    "mainIngredient": row[4],
                },
                "author": row[6]
            })
    
    return menuList

def write_json(data: list[dict], file_path: str):
    with open(file_path, 'w') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

if __name__ == "__main__":
    main()
