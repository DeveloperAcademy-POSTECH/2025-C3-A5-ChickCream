"""
gen_image.py

csv 파일을 json으로 변환한다.

- 사용 방법
    - 처음부터 시작하는 경우
        python get_image.py database.json GEMINI_API_KEY

    - 중간부터 재개하는 경우: 시작 인덱스를 뒤에 포함
        python get_image.py database.json GEMINI_API_KEY 75

- 소스 json 파일 형식
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

from google import genai
from google.genai import types
from PIL import Image
from io import BytesIO
import time
import sys
import json
import os

OUTPUT_DIR = "./image_output"

def create_client(api_key: str) -> genai.Client:
    return genai.Client(api_key=api_key)

def create_prompt(menu_name: str) -> str:
    return f'{menu_name}의 일러스트를 지브리 풍으로 그려줘. 이미지 크기는 정사각형이어야 하고 텍스트는 포함되면 안돼.'

def request_and_save_image(client: genai.Client, menu: dict):
    prompt = create_prompt(menu_name=menu["title"])
    print(f"requested to gemini... prompt was...: {prompt}")

    response = client.models.generate_content(
        model="gemini-2.0-flash-preview-image-generation",
        contents=prompt,
        config=types.GenerateContentConfig(
        response_modalities=['TEXT', 'IMAGE']
        )
    )

    for part in response.candidates[0].content.parts:
        if part.text is not None:
            print(part.text)
        elif part.inline_data is not None:
            image = Image.open(BytesIO((part.inline_data.data)))
            image.save(f'./image_output/{menu["id"]}.png')
            # image.show()

    print("-> completed.")
    time.sleep(3)

def read_json(file_path: str) -> list[dict]:
    with open(file_path) as f:
        data = json.load(f)
        return data

def main():
    if len(sys.argv) < 3:
        print("usage: python get_image.py database.json GEMINI_API_KEY (START_INDEX)")
        sys.exit(1)

    try:
        os.mkdir(OUTPUT_DIR)
    except:
        print(f"{OUTPUT_DIR} 생성에 실패했습니다. 이미 존재하는 디렉토리라면 오류가 아닙니다. 계속 진행합니다.")

    input_file_path = sys.argv[1]
    api_key = sys.argv[2]
    start_index = 0
    if len(sys.argv) == 4:
        start_index = int(sys.argv[3])

    client = create_client(api_key)

    menus = read_json(input_file_path)
    for idx, menu in enumerate(menus):
        if idx < start_index:
            continue

        uid = menu["id"]
        title = menu["title"]
        request_and_save_image(client, menu)
        print(f"[{idx}] {title}'s image generated ... uid={uid}")

if __name__ == "__main__":
    main()
