"""
csv2json.py

csv 파일을 json으로 변환한다.

- 사용 방법
    python csv2json.py raw_database.csv

- 소스 csv 파일 형식
    id,메뉴 이름,휴대성,사먹? 직접?,(단백질) 주재료,담당자
    e7463a12-e339-48bc-afb2-dfdd124cd6b1,훈제 메추리알,휴대 쉬움,사먹기가 편한,달걀,밥
    9522d406-27e6-437a-b2b8-20fb5ae25152,에그마요 샌드위치,휴대 쉬움,사먹기가 편한,달걀,밥

    "휴대성" 컬럼의 값은 다음 두 문자열 중 하나여야 한다.
    - 휴대 쉬움
    - 휴대 어려움

    "사먹? 직접?" 컬럼의 값은 다음 두 문자열 중 하나여야 한다.
    - 휴대 쉬움
    - 사먹기가 편한

- 결과 json 파일 형식
    [
        {
            "id": "7307fa7c-1987-481e-9c7e-d581986b4e97",
            "title": "훈제 메추리알",
            "isPortable": true,
            "isCookable": false,
            "mainIngredient": "달걀",
            "author": "밥"
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
    output_file_path = input_file_path.split(".")


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

            if row[1] == "":
                continue

            menuList.append({
                "id": row[0],
                "title": row[1],
                "isPortable": row[2] == "휴대 쉬움",
                "isCookable": row[3] == "직접 준비하기 쉬운",
                "mainIngredient": row[4],
                "author": row[5]
            })
    
    return menuList

def write_json(data: list[dict], file_path: str):
    with open(file_path, 'w') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

if __name__ == "__main__":
    main()
