# arduino & DHT11 sensing — 챗봇 실습 전 준비 확인

아두이노 IDE 설치·배선·DHT11 스케치 업로드의 **전체 과정은 한 곳에만** 정리되어 있습니다:

👉 **[03_arduino_sensor/arduino_sensor_for_jetson.md](../03_arduino_sensor/arduino_sensor_for_jetson.md)** — 여기서 이미 마쳤다면 아래 체크리스트만 확인하고 [3_dht_chatbot_functioncalling.ipynb](./3_dht_chatbot_functioncalling.ipynb) 로 넘어가세요.

## ✅ 챗봇 실습 전 체크리스트

1. **DHT11 스케치가 아두이노에 업로드**되어 있는가? (핀 2번, 통신속도 9600 — 03 문서의 코드 그대로)
2. **시리얼 모니터는 닫았는가?** — ⚠️ 시리얼 모니터가 열려 있으면 주피터(파이썬)와 포트 충돌로 센서값을 읽을 수 없습니다!
3. **센서 출력은 숫자만**인가? — `Serial.print(temp); Serial.print(","); Serial.println(humid);` 형태.
   `*c` 같은 문자가 섞이면 파이썬 파싱에서 오류가 납니다.
4. **포트 권한**은 부여했는가? — `sudo chmod a+rw /dev/ttyACM0`

체크가 다 되었으면 센서값이 `sensor → arduino → jetson → python` 경로로 챗봇까지 전달될 준비 완료입니다.
