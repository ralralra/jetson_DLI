# 1️⃣ For Arduino. On Jetson Nano

> 🧭 **어디서 실행하나요?** 이 문서의 모든 명령은 **DLI 도커 컨테이너가 아니라 젯슨나노 호스트 터미널**에서 실행합니다.
>
> ⏰ **수업 팁** : [02_python_jupyter의 파이썬 3.8 컴파일](../02_python_jupyter/python_jupyter_venv.md)을 먼저 걸어두고,
> 컴파일이 도는 동안(1시간+) 이 문서의 아두이노 작업을 진행하면 시간이 절약됩니다.

1. arduino.cc   ->  버전 **1.8.19** (버전에 따라 오류가 생기는 경우가 있어 1.8.19로 통일)
2. 젯슨나노 USB 포트에 아두이노 보드 연결
3. 센서 연결 - DHT11 센서 연결

## ARM64용 Java를 설치

**1.시스템에서 패키지 목록 업데이트**

```sudo apt update```


**2.리눅스에서 OpenJDK 8 (Java Development Kit)을 설치하는 명령어***

```sudo apt install openjdk-8-jdk```


**3.Arduino 1.8.19 버전의 리눅스 ARM64(aarch64)용 설치 파일을 다운로드하는 명령어**

```wget https://downloads.arduino.cc/arduino-1.8.19-linuxaarch64.tar.xz```


**4. 다운로드한 Arduino 1.8.19 설치 파일(.tar.xz)을 압축 해제**

```tar -xf arduino-1.8.19-linuxaarch64.tar.xz```

---

**5. 아두이노 폴더**

```cd arduino-1.8.19```


**6. 아두이노 설치 명령실행**

```sudo ./install.sh```


**7.  사용 가능한 모든 TTY(터미널) 및 직렬 포트(Serial Port) 디바이스 목록을 출력**
  - ls → 파일 및 디렉토리 목록을 출력
  - /dev/tty* → /dev/ 디렉토리 내에서 tty로 시작하는 모든 파일 검색

```ls /dev/tty*```

> 💡 **내 아두이노는 어떤 포트?** 보드 종류에 따라 이름이 다릅니다:
> - 정품 우노(Uno) 계열 → **`/dev/ttyACM0`**
> - 저가 호환보드(CH340 칩) → **`/dev/ttyUSB0`**
>
> 확실하게 찾는 법: 아두이노 USB를 **뽑은 상태**에서 `ls /dev/tty*` 실행 → **꽂은 후** 다시 실행 → **새로 생긴 것**이 내 아두이노 포트입니다.
> 아래 명령과 파이썬 코드의 포트 이름은 전부 여기서 찾은 이름으로 통일하세요.

**8. 리눅스에서 특정 직렬 포트 **(/dev/ttyACM0)** 에 대해 모든 사용자에게 읽기(r) 및 쓰기(w) 권한을 부여하는 명령어**

```sudo chmod a+rw /dev/ttyACM0  ```

> 💡 `chmod`는 **재부팅하면 풀립니다.** 매번 하기 귀찮다면 내 계정을 dialout 그룹에 한 번만 등록해두세요 (영구 적용):
>
> ```
> sudo usermod -a -G dialout $USER
> newgrp dialout
> ```


**9. 아두이노 폴더 빠져나오기**

``cd ``


**10. 아두이노 실행**
    
```arduino```

![](../img/ardu.png)


**11. 아두이노가 실행되면 Tools 메뉴에서  board 와 port 설정을 한다.** 7번에서 권한설정을 했던 port를 찾아서 선택하고

  업로드가 잘되는지 빈 파일에서 업로드를 실행해본다.

  포트 설정이 잘못됐다면 맞는 것을 찾아 terminal에서 port 권한설정을 해줘야 한다. 

![](../img/arduport.jpg)

port 설정이 완료되면 테스트 업로드를 해보고  잘된다면 아두이노와 젯슨을 연결한다.

**12. 아두이노 배선**

![](../img/dht1.jpg)

![](../img/ardujetson.jpg)

---

**13. 라이브러리 설치**

![](../img/ardu_lib.png)

tools-LibraryManager 에서 온습도 센서 모델에 맞는 라이브러리를 설치한다. 

내가 사용한건 DHT11 의 저렴한 모듈이다. 

라이브러리 설치가 끝나면 File-example 에서 설치한 라이브러리(dht11) 의 예제를 열고 

배선된 핀번호 와 통신속도를 확인하고 알맞게 수정해준다. 

```
#include <SimpleDHT.h>
int pinDHT11 = 2;
SimpleDHT11 dht11(pinDHT11);

void setup() {
  Serial.begin(9600);
}

void loop() {
  byte temperature = 0;
  byte humidity = 0;
  
  if (dht11.read(&temperature, &humidity, NULL) == SimpleDHTErrSuccess) {
    int temp = (int)temperature;
    int humid = (int)humidity;
    
    // 유효한 범위인지 확인
    if (temp >= 0 && temp <= 50 && humid >= 0 && humid <= 100) {
      Serial.print(temp);
      Serial.print(",");
      Serial.println(humid);
    }
  }
  
  delay(2000);  // 2초 대기
}
```

![](../img/arducode.png)

나는 핀번호 2번과 통신속도 9600으로 설정했다. 

> ⚠️ **통신속도(baud rate)는 세 곳이 전부 같아야 합니다** — 하나라도 다르면 글자가 깨지거나 아무것도 안 나옵니다:
>
> | 위치 | 설정 |
> |---|---|
> | 아두이노 스케치 | `Serial.begin(9600);` |
> | 시리얼 모니터 (우측 하단) | `9600 baud` |
> | 파이썬 코드 (04 챗봇) | `serial.Serial('/dev/ttyACM0', 9600, ...)` |
>
> 인터넷 예제 중에 `115200`을 쓰는 코드도 있으니, 복사해왔다면 통신속도부터 확인하세요.

아두이노에 업로드가 완료되면 상단 오른쪽에 돋보기 모양버튼(시리얼 통신 모니터)을 눌러서 센서값을 확인한다.

아두이노에서 감지한 온습도 센싱값을 
sensor - arduino - jetson - python 을 거치면서 우리에게 전달 된다.

센서값을 불러올때는 숫자만 출력해야 한다 
```
Serial.print(temp);
Serial.print("*c ,");
Serial.println(humid);
```
에서 *c 같은 숫자가 아닌 데이터를 출력하면 오류가 난다

![](../img/serial.jpg)

시리얼 모니터를 열고있으면 주피터와 충돌로 아두이노 값을 불러올수 없다

확인했으면 시리얼모니터를 닫아준다





[🙋‍♂️ next jupyter notebook](../02_python_jupyter/python_jupyter_venv.md)

[🙋‍♂️dht_chatbot_functioncalling](../04_chatbot/3_dht_chatbot_functioncalling.ipynb)
