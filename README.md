# 🤖 Jetson Nano 2GB — DLI 교육 & 젯봇미니 프로젝트

젯슨나노 2GB로 **NVIDIA DLI 수료증**을 받고, 이어서 **젯봇미니**까지 만드는 전체 교육 자료 저장소입니다.
아래 폴더 순서(01 → 06)가 곧 학습 순서입니다.

## 📂 폴더 구성

| 순서 | 폴더 | 내용 |
|---|---|---|
| 1️⃣ | [01_jetson_dli_course](./01_jetson_dli_course) | 젯슨나노 초기 세팅부터 **DLI "Getting Started with AI on Jetson Nano" 수료증**까지. 👉 [전체 가이드](./01_jetson_dli_course/0_DLI_수료과정_가이드.md)부터 시작하세요! |
| 2️⃣ | [02_python_jupyter](./02_python_jupyter) | 파이썬 3.8 설치와 가상환경(venv), 주피터 노트북 세팅 — **DLI 실습(JupyterLab) 전에 주피터가 처음이라면 먼저 훑어보세요** |
| 3️⃣ | [03_arduino_sensor](./03_arduino_sensor) | 아두이노 + DHT 온습도 센서를 젯슨나노에 연결하기 |
| 4️⃣ | [04_chatbot](./04_chatbot) | OpenAI Function Calling으로 센서 데이터를 읽는 챗봇 만들기 |
| 5️⃣ | [05_jetbotmini](./05_jetbotmini) | 젯봇미니 조립·설치·AI·ROS 과정 (Yahboom Jetbot Mini). 👉 [학습 순서 가이드](./05_jetbotmini/00_학습순서_가이드.md)부터! |
| 6️⃣ | [06_data_analysis](./06_data_analysis) | 데이터 분석 실습 — 충남지역 데이터 분석·지도 시각화 |
| 7️⃣ | [07_attendance_system](./07_attendance_system) | 얼굴인식 자동 출석 시스템 만들기 (face_recognition + USB 카메라) |
| 🖼️ | [img](./img) | 문서에서 공용으로 쓰는 이미지 모음 |

## 🚀 처음 오셨다면

1. **[01_jetson_dli_course/0_DLI_수료과정_가이드.md](./01_jetson_dli_course/0_DLI_수료과정_가이드.md)** — 이미지 굽기 이후부터 수료증 발급까지 13단계 순서도와 함께 정리되어 있습니다.
2. 수료증을 받았다면 → [05_jetbotmini](./05_jetbotmini) 로 넘어가 젯봇미니를 만들어보세요.

## 📚 각 폴더 안 문서 순서

- **01_jetson_dli_course** : `0_전체 가이드` → `1_시작(이미지 굽기)` → `2_한글설치` → `3_도커와 스왑` → `4_classification 실습 노트북` / 매 수업 공통 : `5_깃허브 출석체크`
- **04_chatbot** : `1_function_calling` → `2_arduino_dhtSensor` → `3_dht_chatbot(노트북)` → `4_api_chatbot`
- **05_jetbotmini** : `00_학습순서_가이드.md` 먼저! (필수/스킵 구분 — PDF 40개 중 핵심 10개만 보면 완주) → 실습 중엔 `01_전체과정_한글정리.md` (영문 PDF 한글 요약본)
