"""
imageRename2UUID.py

이미지를 순회하면서

- 사용 방법
    python imageRename2UUID.py image_input image_output db.json
"""

import sys
import os
from PIL import Image
import json
from typing import List, Dict

def change_file_extension(original_path: str, new_extension: str = "jpg") -> str:
    chunks = original_path.split(".")
    return ".".join(chunks[:-1]) + f".{new_extension}"

def read_json(file_path: str) -> List[Dict]:
    with open(file_path, encoding='utf-8') as f:
        return json.load(f)

import unicodedata

def normalize(s: str) -> str:
    return unicodedata.normalize("NFC", s.strip())

def main():
    if len(sys.argv) != 4:
        print("usage: python imageRename2UUID.py image_input image_output db.json")
        sys.exit(1)

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]
    db_json_filepath = sys.argv[3]

    data = read_json(db_json_filepath)

    try:
        os.makedirs(output_dir, exist_ok=True)
    except OSError as e:
        print(f"{output_dir} 디렉토리 생성 실패: {e}")
        sys.exit(1)

    files = os.listdir(input_dir)
    for file_name in files:
        print(file_name)
        if not file_name.lower().endswith(".png"):
            continue

        file_title = file_name[:-4].strip()
        matched_id = None
        for item in data:
            print("file_title " + file_title)
            print("found " + item["title"])
            print(item["id"])
            # if item["title"].strip() == file_title:
            if normalize(item["title"]) == normalize(file_title):
                matched_id = item["id"]
                break
        print()

        if not matched_id:
            print(f"[경고] {file_name} 에 대응되는 ID를 찾을 수 없습니다.")
            continue

        input_path = os.path.join(input_dir, file_name)
        output_path = os.path.join(output_dir, f"{matched_id}.jpg")

        try:
            img = Image.open(input_path).convert('RGB')
            img.save(output_path, 'JPEG')
            print(f"{output_path} saved...")
        except Exception as e:
            print(f"[에러] {file_name} 처리 중 오류: {e}")

if __name__ == "__main__":
    main()
