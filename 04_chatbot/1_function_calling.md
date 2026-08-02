
[openai_funchingColling](https://platform.openai.com/docs/guides/function-calling)

Function calling
================
# 🚀 OpenAI Function Calling 쉽게 이해하기!

Function Calling이란 **GPT가 단순한 답변을 넘어서 직접 기능을 실행할 수 있도록 만드는 기능**입니다.  
이를 활용하면 GPT가 API를 호출하거나 실제 기능을 수행하는 **스마트한 AI**로 변신할 수 있습니다!  

---

## 📌 1️⃣ Function Calling이란?

> **기본 개념:**  
> 기존 GPT는 단순히 텍스트만 생성하지만, Function Calling을 사용하면 GPT가 직접 **특정 기능(함수)**을 실행할 수 있습니다.

💡 예를 들어,  
- **"서울 날씨 알려줘"** 👉 Function Calling을 사용해 실제 **날씨 API를 호출하여 정확한 정보 제공!**  
- **"피자 주문해줘"** 👉 Function Calling을 사용해 **실제 피자 주문 서비스와 연동 가능!**  

**즉, Function Calling을 사용하면 GPT가 단순한 AI에서 "진짜 기능을 수행하는 AI"로 발전합니다!** 🚀  

---

## 📌 2️⃣ Function Calling 작동 방식

🛠️ **Function Calling은 아래 3단계로 동작합니다.**  

### ✅ 1단계: 사용자가 요청
사용자가 GPT에게 질문을 합니다.  
```
"내일 날씨 알려줘!"
```

### ✅ 2단계: GPT가 Function Calling을 사용해 함수 실행

GPT는 Function Calling을 통해 날씨 API를 호출하는 함수를 실행합니다.

```
get_weather(location="Seoul", date="tomorrow")
```

### ✅ 3단계: GPT가 결과를 사용자에게 알려줌

GPT가 API에서 받은 데이터를 바탕으로 응답을 생성합니다.

```
"내일 서울 날씨는 맑고, 기온은 27°C입니다!"
```

🎯 이제 GPT가 단순한 문장 생성이 아니라, 실제 기능을 실행해서 더 정확한 정보를 줄 수 있습니다!

## 📌 3️⃣ Function Calling을 어디에 활용할 수 있을까?
#### ✅ 실제 기능을 수행하는 AI 챗봇 만들기
#### ✅ 실제 데이터를 가져오기 (날씨, 주식, 일정 등)
#### ✅ 자동화 시스템 (예약, 알림, 주문 등)

### 💡 Function Calling을 사용하면 GPT가 진짜 일을 처리하는 AI로 진화! 🚀

## 📌 4️⃣ Function Calling 예제
### 🌟 예제 1: 음식 주문하기

```사용자: "피자 주문해줘"```

🔹 **GPT가 Function Calling을 사용해 주문 함수 실행**

```order_pizza(size="large", toppings=["pepperoni", "cheese"])```

🔹 **GPT가 결과를 사용자에게 전달**

```"주문이 완료되었습니다! 배달 예상 시간은 30분입니다."```

### 🌟 예제 2: 날씨 확인하기

```사용자: "서울 날씨 알려줘"```

🔹 **GPT가 날씨 API를 호출하는 함수 실행**

```get_weather(location="Seoul", date="today")```

🔹 **GPT가 API에서 가져온 데이터를 바탕으로 응답**

```"현재 서울의 날씨는 맑음, 기온은 25°C입니다."```

#### 🔥 Function Calling을 사용하면 GPT가 단순한 대답을 넘어서, 실제 정보를 가져오고 실행할 수 있습니다! 🔥

## 📌 5️⃣ Function Calling이 왜 필요할까?
✅ 기존 GPT는 단순히 텍스트만 생성

✅ Function Calling을 사용하면 GPT가 실제 기능을 실행 가능

✅ API, 데이터베이스, 외부 시스템과 연동하여 더 정확한 응답 가능


#### 🎯 쉽게 말해, Function Calling을 쓰면 GPT가 단순한 대화형 AI → 진짜 기능을 하는 AI로 업그레이드됩니다! 🚀

## 📌 6️⃣ Function Calling 요약

❌ 기존 GPT: 단순한 텍스트 생성

✅ Function Calling 사용한 GPT: 실제 기능을 실행하고 API와 연동 가능!

🔥 Function Calling을 활용하면 GPT가 **"대화형 AI" → "실제 기능을 수행하는 AI"**로 진화합니다! 🔥

---

# 🍎 실습: 과일 가격 챗봇으로 5단계 따라 하기

> **여기서 중요한 포인트! — GPT는 함수를 직접 실행하지 않습니다.**
>
> 1. GPT는 "이 함수를 이 인자로 실행해주세요"라고 **알려주기만** 합니다.
> 2. 실제 실행은 **우리 코드가 직접** 하고, 결과를 GPT에게 다시 알려줍니다.
> 3. GPT는 그 결과를 활용해 최종 답변을 만듭니다.
>
> 대화로 표현하면:
> ```
> 사용자:  GPT야, 'get_fruit_price'라는 함수를 알려줄게. 과일 가격을 알려주는 함수야.
> GPT:    네 알겠습니다.
> 사용자:  배 8개를 사려면 얼마야?
> GPT:    함수 'get_fruit_price'를 실행해주세요. 과일 이름은 "배"입니다.   ← 실행 요청만!
> 사용자:  (함수 실행 후) 실행 결과, "배는 800원"
> GPT:    배는 1개에 800원이니까 8개 사면 6,400원입니다.
> ```

## 준비: API 키 설정

```python
import os, json
from openai import OpenAI

os.environ['OPENAI_API_KEY'] = '여기에_본인_키_입력'   # ⚠️ 키를 코드/깃허브에 남기지 마세요!
client = OpenAI()
```

## Step 1 — 함수를 정의한다

과일 이름을 넣으면 가격을 돌려주는 평범한 파이썬 함수입니다.

```python
def get_fruit_price(fruit_name):
    fruit_prices = {
        '사과': '1000',
        '바나나': '500',
        '오렌지': '750',
        '배': '800'
    }
    if fruit_name in fruit_prices:
        return fruit_prices[fruit_name]
    return '가격 정보가 없는 과일입니다'
```

## Step 2 — 함수 설명서를 형식에 맞춰 작성한다

GPT에게 "이런 함수가 있어"라고 알려주는 설명서입니다. **description을 잘 쓸수록 GPT가 함수를 잘 골라 씁니다.**

```python
use_functions = [
    {
        "type": "function",
        "function": {
            "name": "get_fruit_price",                    # 함수 이름
            "description": "Returns the current price of the specified fruit.",  # 함수 설명
            "parameters": {
                "type": "object",
                "properties": {
                    "fruit_name": {                        # 인자 설명
                        "type": "string",
                        "description": "The name of the fruit to retrieve the price for (e.g., '사과', '바나나')."
                    }
                },
                "required": ["fruit_name"]
            }
        }
    }
]
```

## Step 3 — GPT에게 질문해서 어떤 함수를 부를지 알아낸다

```python
messages = [
    {"role": "system", "content": "You are a helpful assistant. Use the supplied tools to retrieve fruit prices for the user."},
    {"role": "user", "content": "Hi, can you tell me the price of 3 apples?"}
]

response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=messages,
    tools=use_functions        # ← 함수 설명서를 함께 전달!
)

response_message = response.choices[0].message
tool_calls = response_message.tool_calls
```

`tool_calls`를 출력해보면 GPT가 **어떤 함수를 어떤 인자로 부를지** 알려줍니다 (아직 실행 전!):

```
[ChatCompletionMessageToolCall(id='call_...', function=Function(
    arguments='{"fruit_name":"사과"}', name='get_fruit_price'), type='function')]
```

## Step 4 — 함수를 (우리가 직접) 실행한다

```python
proc_messages = []

if tool_calls:
    available_functions = {"get_fruit_price": get_fruit_price}

    for tool_call in tool_calls:
        messages.append(response_message)                     # GPT의 함수 호출 요청을 대화에 기록

        function_name = tool_call.function.name
        function_to_call = available_functions[function_name]
        function_args = json.loads(tool_call.function.arguments)
        function_response = function_to_call(**function_args)  # ← 함수 실행!

        proc_messages.append({
            "tool_call_id": tool_call.id,
            "role": "tool",                                    # 함수 실행 결과는 role="tool"
            "name": function_name,
            "content": function_response,
        })

messages += proc_messages
```

## Step 5 — 실행 결과를 포함해 다시 GPT에게 물어본다

```python
second_response = client.chat.completions.create(
    model='gpt-4o-mini',
    messages=messages,      # 질문 + 함수 호출 정보 + 실행 결과가 모두 들어있음
)

print(second_response.choices[0].message.content)
# >> The price of 3 apples is 3,000 won, as each apple costs 1,000 won.
```

## ✅ 5단계 요약

| 단계 | 하는 일 | 누가? |
|---|---|---|
| 1 | 함수 정의 | 우리 |
| 2 | 함수 설명서 작성 | 우리 |
| 3 | 질문 + 설명서 전달 → 호출할 함수/인자 받기 | GPT |
| 4 | 함수 실제 실행 → 결과를 대화에 추가 | **우리** |
| 5 | 결과 포함해 재질문 → 최종 답변 | GPT |

[🙋‍♂️ 다음: 챗봇 실습 전 센서 체크리스트](./2_arduino_dhtSensor.md)
