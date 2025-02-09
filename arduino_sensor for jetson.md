#  For Arduino. On Jetson Nano

1. arduino.cc   ->  버전 1.8.19
2. 젯슨나노에 아두이노 보드 연결
3. 센서 연결 -dht11 센서 연결. 

# ARM64용 Java를 설치
```
sudo apt update
sudo apt install openjdk-8-jdk
wget https://downloads.arduino.cc/arduino-1.8.19-linuxaarch64.tar.xz
tar -xf arduino-1.8.19-linuxaarch64.tar.xz
cd arduino-1.8.19
```

```sudo ./install.sh```

```ls /dev/tty*```

```sudo chmod a+rw /dev/ttyACM0  ```

``cd ``

``arduino```
