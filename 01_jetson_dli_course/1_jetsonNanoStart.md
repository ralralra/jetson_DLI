# 1️⃣ 젯슨나노 시작하기 — SD 카드 굽기

젯슨나노는 SD 카드에 담긴 OS로 부팅합니다. 먼저 SD 카드를 포맷하고 이미지 파일을 구워야 합니다.

1. **이미지 다운로드** — [NVIDIA 다운로드 페이지](https://developer.nvidia.com/embedded/downloads#?search=nano)에서 **JetPack 4.6.1** 을 받습니다.
2. **SD Card Formatter** 로 SD 카드를 포맷합니다.
3. **balenaEtcher** 로 이미지를 SD 카드에 굽습니다.
4. 자세한 과정은 [NVIDIA 공식 가이드](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write)를 참고하세요.

![](../img/010.png)

---

# 2️⃣ jtop 설치 — 시스템 모니터링

jtop은 젯슨나노의 CPU/GPU 사용량과 온도를 한눈에 보여주는 모니터링 도구입니다.

터미널을 열고 한 단계씩 진행합니다.

**① 패키지 목록 갱신 + 업그레이드**

```
sudo apt-get update
sudo apt-get upgrade
```

- `update` : 최신 정보를 기반으로 소프트웨어를 설치할 수 있도록 목록을 갱신
- `upgrade` : 이미 설치된 패키지를 최신 상태로 업데이트

**② pip 설치**

```
sudo apt install python3-pip
```

**③ jetson-stats(jtop) 설치 후 재부팅**

```
sudo -H pip3 install -U jetson-stats
reboot
```

**④ 설치 확인** — 재부팅 후:

```
pip3 list | grep jetson
```

목록에 `jetson-stats`가 보이면 성공! `jtop` 명령으로 실행합니다. (종료는 `q`)

![jtop](../img/003.png)

---

# 3️⃣ 쿨링팬 설치와 자동 제어

jtop으로 온도를 확인해 보면 온도가 꽤 높습니다. 쿨링팬을 장착하고 자동 제어를 설정합니다.

## (선택) 팬이 잘 도는지 즉시 확인

장착 직후 한 줄로 팬을 돌려볼 수 있습니다:

```
sudo sh -c 'echo 128 > /sys/devices/pwm-fan/target_pwm'   # 끄기: 128 대신 0
```

## 자동 팬 제어 설치 — 이 방법 하나면 끝!

`jetson-fan-ctl`을 설치하면 **부팅할 때 자동으로 시작**되고, **온도에 따라 팬 속도를 알아서 조절**해 줍니다.
터미널에서 한 줄씩:

```
git clone https://github.com/jugfk/jetson-fan-ctl.git
cd jetson-fan-ctl
sudo sh install.sh
```

설치가 끝나면 `automagic-fan` 서비스가 자동 등록되어, **재부팅해도 항상 동작**합니다.
별도의 스크립트 작성이나 서비스 등록 작업은 필요 없습니다.

### 동작 확인 및 제어

```
sudo service automagic-fan status   # 상태 확인 (active면 성공, 종료는 q)
sudo service automagic-fan stop     # 잠깐 중지
sudo service automagic-fan start    # 다시 시작
```

`jtop`으로 온도가 내려가는지 확인해 보세요. 약 10도 정도 떨어지는 경우도 있습니다.

---

# 4️⃣ 카메라 연결과 테스트

USB 카메라와 CSI 카메라 중 **가지고 있는 카메라에 맞는 방법 하나만** 따라 하면 됩니다.

## 4-A. USB 카메라 (일반 웹캠)

[예제 출처: jetsonhacks/USB-Camera](https://github.com/jetsonhacks/USB-Camera)

USB 포트에 카메라를 꽂고, 예제를 내려받습니다:

```
git clone https://github.com/jetsonhacks/USB-Camera.git
```

`ls` 명령으로 `USB-Camera` 폴더가 생긴 것을 확인하고 안으로 들어가면, 파이썬 예제 파일(.py)들이 있습니다.

![jtop](../img/006.png)

카메라 테스트와 얼굴 인식(눈·코·입 찾기)을 각각 실행해 봅니다:

```
cd USB-Camera
python3 usb-camera-gst.py 
python3 face-detect-usb.py 
```

## 4-B. CSI 카메라 (라즈베리파이 카메라 모듈 v2 등)

[예제 출처: JetsonHacksNano/CSI-Camera](https://github.com/JetsonHacksNano/CSI-Camera)

**연결 (⚠️ 전원을 끈 상태에서!)**

1. CSI 커넥터의 검은색 걸쇠를 위로 살짝 들어 올린다.
2. 리본 케이블을 **금속 접점이 방열판(히트싱크) 쪽**을 향하게 끼운다. (파란 면이 바깥쪽)
3. 걸쇠를 다시 눌러 고정하고 전원을 켠다.

**인식 확인**

```
ls /dev/video0
```

**예제 실행**

```
git clone https://github.com/JetsonHacksNano/CSI-Camera.git
```

카메라 테스트와 얼굴 인식을 각각 실행해 봅니다:

```
cd CSI-Camera
python3 simple_camera.py
python3 face_detect.py
```

창을 닫을 때는 창을 클릭한 후 `Ctrl+C` 또는 `q`

> 💡 CSI 카메라는 DLI 도커 컨테이너 안에서도 그대로 사용할 수 있습니다.
> JupyterLab 실습에서 `usb_camera.ipynb` 대신 `csi_camera.ipynb` 를 열면 됩니다.

[🙋‍♂️ 다음 단계: 한글 설치](./2_한글설치.md)
