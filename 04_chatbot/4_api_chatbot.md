# 🌤️ 응용: 날씨 API 챗봇 — 함수를 여러 개 주고 GPT가 골라 쓰게 하기

[1_function_calling.md](./1_function_calling.md)의 과일 가격 함수는 우리가 만든 가짜 데이터였습니다.
이번에는 **진짜 외부 API**(OpenWeatherMap)를 함수로 감싸서, "대전 날씨 어때?"에 실시간으로 답하는 챗봇을 만듭니다.

> 🧭 실행 위치: 젯슨나노 호스트의 가상환경(`source myenv/bin/activate`) 또는 코랩. 도커 컨테이너 아님!

## 1. 날씨 API 키 발급

1. https://openweathermap.org/ 회원가입
2. My API keys 메뉴에서 무료 키 발급 (활성화까지 몇 분~몇 시간 걸릴 수 있음)

> ⚠️ 발급받은 키는 코드·문서·깃허브에 그대로 적지 말고, 실습 때만 입력하세요.

## 2. 날씨 함수 정의

지역 이름을 넣으면 현재 날씨·온도·습도를 돌려주는 함수입니다:

```python
import requests, json

def get_current_weather(city):
    key = '여기에_발급받은_키_입력'

    # ① 도시 이름 → 위도/경도
    geo_api = f"http://api.openweathermap.org/geo/1.0/direct?q={city}&limit=5&appid={key}"
    location = json.loads(requests.get(geo_api).text)
    lat = location[0]['lat']
    lon = location[0]['lon']

    # ② 위도/경도 → 현재 날씨
    weather_api = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={key}"
    result = json.loads(requests.get(weather_api).text)

    weather = result['weather'][0]['main']
    temp = round(result['main']['temp'] - 273.15, 2)   # 켈빈 → 섭씨
    hum = result['main']['humidity']

    return str({'condition': weather, 'temperature': temp, 'humidity': hum})
```

동작 확인:

```python
print(get_current_weather('Daejeon'))
# {'condition': 'Clouds', 'temperature': 27.3, 'humidity': 65}
```

## 3. 함수 설명서를 함수 목록에 추가

```python
use_functions = [
    # ... 기존 get_fruit_price 설명서가 있다면 그대로 두고 ...
    {
        "type": "function",
        "function": {
            "name": "get_current_weather",
            "description": "Retrieve the current weather information for a specified city. Returns the weather description, temperature in Celsius, and humidity percentage.",
            "parameters": {
                "type": "object",
                "properties": {
                    "city": {
                        "type": "string",
                        "description": "The name of the city to get the weather for."
                    }
                },
                "required": ["city"]
            }
        }
    }
]
```

## 4. 함수 여러 개 등록도 가능? Yes!

`get_fruit_price`와 `get_current_weather`를 **둘 다** `use_functions` 목록에 넣고,
실행 매핑에도 둘 다 등록하면 — **어떤 함수를 쓸지는 GPT가 질문을 보고 알아서 결정합니다:**

```python
available_functions = {
    "get_fruit_price": get_fruit_price,
    "get_current_weather": get_current_weather,
}
```

| 사용자 질문 | GPT가 고르는 함수 |
|---|---|
| "사과 3개 얼마야?" | `get_fruit_price(fruit_name='사과')` |
| "대전 날씨 어때?" | `get_current_weather(city='Daejeon')` |
| "안녕!" | 함수 안 씀 (그냥 대답) |

나머지 흐름(Step 3~5: 질문 → 함수 실행 → 결과 포함 재질문)은 [1_function_calling.md의 5단계](./1_function_calling.md)와 완전히 동일합니다.

## 5. 여기까지 되면 — 센서도 똑같이!

이제 눈치채셨겠지만, **[3_dht_chatbot 노트북](./3_dht_chatbot_functioncalling.ipynb)의 센서 함수도 같은 패턴**입니다:

- `get_current_weather(city)` → 인터넷 API에서 값을 가져옴
- `get_temperature()` / `get_humidity()` → **아두이노 시리얼**에서 값을 가져옴

함수 안의 데이터 출처만 다를 뿐, GPT에게 설명서를 주고 → GPT가 고르고 → 우리가 실행하고 → 결과로 답하는 구조는 전부 같습니다.
날씨 함수와 센서 함수를 **한 챗봇에 모두 등록**하면 "지금 우리 교실 온도랑 서울 날씨 비교해줘" 같은 질문도 처리할 수 있어요. 도전해보세요! 🚀

## 트러블슈팅

| 증상 | 원인/해결 |
|---|---|
| `401 Unauthorized` | 키가 아직 활성화 안 됨 (발급 직후엔 몇 분~몇 시간 대기) 또는 키 오타 |
| `location[0]` IndexError | 도시 이름을 못 찾음 — 영문 이름 사용 (예: `Daejeon`, `Seoul`) |
| 코드 복사 후 `SyntaxError` | 슬라이드/블로그에서 복사하면 따옴표가 곱은따옴표(`'` → `’`)로 바뀌는 경우가 있음 — 이 문서에서 복사하면 안전합니다 |
