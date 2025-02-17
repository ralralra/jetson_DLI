시리얼 모니터를 열고있으면 주피터에서 아두이노 값을 불러올수 없다

아두이노에서는 DHT11 같은 온습도센서를 읽어오는 코드를 업로드 한다 
아두이노 스케치 코드
```C
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

아두이노에서 감지한 온습도 센싱값을 
sensor - arduino - jetson - python 을 거치면서 우리에게 전달 된다.

센서값을 불러올때는 숫자만 출력해야 한다 
```
Serial.print(temp);
Serial.print("*c ,");
Serial.println(humid);
```
에서 *c 같은 숫자가 아닌 데이터를 출력하면 오류가 난다
