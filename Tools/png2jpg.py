"""
png2jpg.py

png 파일을 jpg로 변환한다.

- 사용 방법
    python png2jpg.py image_output image_output_jpg
"""

import sys
import os
from PIL import Image

def change_file_extension(original_path: str, new_extension: str = "jpg") -> str:
    chunks = original_path.split(".")
    return ".".join(chunks[0:-1]) + f".{new_extension}"

def main():
    if len(sys.argv) != 3:
        print("usage: python png2jpg.py image_output image_output_jpg")
        sys.exit(1)

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    try:
        os.mkdir(output_dir)
    except:
        print(f"{output_dir} 생성에 실패했습니다. 이미 존재하는 디렉토리라면 오류가 아닙니다. 계속 진행합니다.")

    files = os.listdir(input_dir)
    for file_name in files:
        if not file_name.lower().endswith("png"):
            continue
        
        input_path = f"{input_dir}/{file_name}"
        output_path = f"{output_dir}/{file_name}"
        img = Image.open(input_path).convert('RGB')
        img.save(change_file_extension(original_path=output_path), 'jpeg')

        print(f"{output_path} saved...")
    
if __name__ == "__main__":
    main()
