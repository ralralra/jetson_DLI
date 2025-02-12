#  For Arduino. On Jetson Nano

1. arduino.cc   ->  버전 1.8.19
2. 젯슨나노에 아두이노 보드 연결
3. 센서 연결 -dht11 센서 연결. 

# ARM64용 Java를 설치

1.시스템에서 패키지 목록 업데이트

```sudo apt update```


2.리눅스에서 OpenJDK 8 (Java Development Kit)을 설치하는 명령어

```sudo apt install openjdk-8-jdk```


3.Arduino 1.8.19 버전의 리눅스 ARM64(aarch64)용 설치 파일을 다운로드하는 명령어

```wget https://downloads.arduino.cc/arduino-1.8.19-linuxaarch64.tar.xz```


4. 다운로드한 Arduino 1.8.19 설치 파일(.tar.xz)을 압축 해제

```tar -xf arduino-1.8.19-linuxaarch64.tar.xz```

---

5. 아두이노 폴더 

```cd arduino-1.8.19```


6. 아두이노 설치 명령실행

```sudo ./install.sh```


7.  사용 가능한 모든 TTY(터미널) 및 직렬 포트(Serial Port) 디바이스 목록을 출력
  - ls → 파일 및 디렉토리 목록을 출력
  - /dev/tty* → /dev/ 디렉토리 내에서 tty로 시작하는 모든 파일 검색

```ls /dev/tty*```


8. 리눅스에서 특정 직렬 포트(/dev/ttyACM0)에 대해 모든 사용자에게 읽기(r) 및 쓰기(w) 권한을 부여하는 명령어

```sudo chmod a+rw /dev/ttyACM0  ```


9. 아두이노 폴더 빠져나오기

``cd ``


10. 아두이노 실행
    
```arduino```
