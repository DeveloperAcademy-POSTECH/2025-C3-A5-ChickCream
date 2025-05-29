# 데이터베이스 구축 도구

- 데이터베이스 구축을 위한 도구들

## 1. 목표
    1. 스프레드시트에서 공동 작업한 데이터셋을 Swift에서 쉽게 다룰 수 있는 JSON 형태로 변환
    2. 데이터셋의 메뉴명으로 gemini-2.0-flash-preview-image-generation를 통해 이미지 생성 (png)
    3. 생성된 PNG 이미지셋을 JPEG로 변환

## 2. 세팅

- Requirement: python 3.10 이상
- Dependencies (별도 가상환경에서 설치하는 것을 추천)
    ```bash
    python -m venv heebob_venv
    source heebob_venv/bin/activate
    pip install Pillow
    pip install -U google-genai
    ```

## 3. 인스트럭션

### (1) CSV 준비
1. 스프레드시트에서 각 팀원이 작업한 내용을 하나의 워크시트로 합칩니다.
2. 워크시트의 가장 왼쪽에 ID 컬럼을 추가하고, UUID4 방식으로 UID를 각 로우에 붙여둡니다.
    - UUID4 생성 수식 ([ref](https://stackoverflow.com/a/65878001))
        ```
        =CONCATENATE(MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),"-",MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),"-4",MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),"-",MID("89ab",RANDBETWEEN(1,4),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),"-",MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1),MID("0123456789abcdef",RANDBETWEEN(1,16),1))
        ```
3. CSV 파일로 다운로드합니다. 이 폴더에 두는 것을 추천합니다.

### (2) CSV -> JSON 변환

"2. 세팅"에서 만든 가상환경을 활성화해두고, 다음을 실행합니다.

```bash
python csv2json.py "(1)CSV준비에서다운로드한CSV파일.csv"
```

### (3) 이미지 생성

"2. 세팅"에서 만든 가상환경을 활성화해두고, 다음을 실행합니다. JSON 파일로의 변환이 완료된 상태여야 합니다.

```bash
python gen_image.py "(2)CSVJSON변환결과JSON파일.json" GEMINI_API_KEY
# GEMINI_API_KEY는 Bob에게 문의해주세요.
```

### (4) 이미지 PNG -> JPEG 변환

이미지 생성이 완료된 상태에서 다음을 실행합니다.

```bash
python gen_image.py "(2)CSVJSON변환결과JSON파일.json" GEMINI_API_KEY
# GEMINI_API_KEY는 Bob에게 문의해주세요.
```
