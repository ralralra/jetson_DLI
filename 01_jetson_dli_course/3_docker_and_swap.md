# 1️⃣doker 설치와 준비

nvidia에서 제공되는 머신러닝 실습을 하기위해 도커컨텐이너를 만들고 
그곳에서 실습을 실행하기 위한 과정이다. 

## 도커(Docker)를 사용하는 이유

NVIDIA의 DLI 과정에서는 보통 AI, 머신러닝(ML), 딥러닝(DL) 관련 실습을 진행하는데
이 과정에서 Docker를 사용한다.

### 1. 환경 설정의 편리함
AI/ML/DL 개발에는 다양한 라이브러리(PyTorch, TensorFlow, CUDA 등)가 필요

**📌 문제점:** 각 라이브러리 버전이 다르면 충돌할 수도 있음.

**📌 해결책:** 도커 컨테이너를 사용하면, 모든 종속성을 미리 설정된 환경에서 실행할 수 있음.

🚀 즉, 참가자마다 개별적으로 라이브러리를 설치할 필요 없이, 동일한 환경에서 실습 가능!


### 2. 호환성 문제 해결
DLI 과정에서는 NVIDIA GPU가 필요할 가능성이 큼.

**📌 문제점:** CUDA, cuDNN, 드라이버 버전이 맞지 않으면 GPU 가속이 안 될 수 있음.

**📌 해결책:** 도커 컨테이너에는 적절한 CUDA 및 cuDNN 환경이 포함되어 있어서, 실행 환경이 통일됨.

💡 즉, 도커 컨테이너를 사용하면 하드웨어 및 드라이버 호환성 문제를 방지할 수 있음!

### 3. 재현성 & 일관성 유지
AI 실험을 진행할 때, 환경이 조금만 달라져도 결과가 달라질 수 있다.

**📌 문제점:** "내 컴퓨터에서는 잘 되는데, 왜 네 컴퓨터에서는 안 돼?"

**📌 해결책:** 도커는 특정 환경(파이썬 패키지, GPU 드라이버 등)을 완전히 동일하게 유지할 수 있어.

🔄 즉, 어떤 시스템에서도 동일한 실험 결과를 재현할 수 있도록 보장해 줌!

### 4. 실행 속도 최적화
NVIDIA 도커(nvidia-docker)는 GPU 가속을 지원하는 컨테이너 환경을 제공

**📌 문제점:** 일반적인 가상환경(예: conda)에서는 GPU 활용이 어려울 수도 있음.

**📌 해결책:** nvidia-docker를 사용하면, 컨테이너 내부에서 GPU 자원을 효율적으로 사용할 수 있음.

🔥 즉, 도커 컨테이너를 사용하면 GPU 성능을 최대로 활용할 수 있음!

### 5. 손쉬운 배포 & 공유
DLI 과정이 끝난 후에도, 동일한 환경을 유지하면서 다른 사람과 공유할수 있다.

**📌 문제점:** 실습한 코드를 다른 PC에서 실행하려면 환경을 다시 설정해야 할 수도 있음.

**📌 해결책:** 도커 컨테이너를 공유하면, 어떤 시스템에서도 동일한 환경에서 실행 가능!

🌍 즉, 도커 이미지를 공유하면 실험 및 연구를 쉽게 재현하고 배포할 수 있음!

## 도커의 원리 — 컨테이너는 어떤 "가상환경"인가?

도커도 가상환경의 한 종류지만, 가상머신(VM)처럼 OS를 통째로 하나 더 띄우는 방식이 **아니다**.

### VM vs 컨테이너

| | 가상머신(VM) | 도커 컨테이너 |
|---|---|---|
| 구조 | 하이퍼바이저 위에 **게스트 OS 전체**를 설치 | 호스트 **리눅스 커널을 공유**하고 프로세스만 격리 |
| 크기/속도 | 수 GB, 부팅에 수 분 | 수백 MB, 시작 몇 초 |
| 젯슨나노 2GB | ❌ 램 부족으로 사실상 불가 | ✅ 가능 — DLI가 도커를 택한 이유 |

### 격리를 만드는 리눅스 커널의 두 기능

1. **네임스페이스(namespace)** : 컨테이너 안 프로세스에게 자기만의 파일시스템·네트워크·프로세스 목록만 보이게 한다. 그래서 컨테이너 안은 별도의 컴퓨터처럼 보인다.
2. **cgroups** : 컨테이너가 쓸 CPU·메모리 자원에 상한을 건다. 우리가 쓰는 `--memory=500M --memory-swap=4G` 옵션이 바로 cgroups 기능이다.

### 이미지와 컨테이너의 관계

- **이미지** = 실행에 필요한 모든 것(우분투 라이브러리 + CUDA + PyTorch + JupyterLab + 실습 노트북)을 **층층이(layer) 쌓아 얼려둔 스냅샷**. 읽기 전용이다.
- **컨테이너** = 이미지를 실행한 **인스턴스**. 같은 이미지로 몇 개든 띄울 수 있다.
- `--rm` 옵션 때문에 컨테이너는 종료 시 삭제된다. 그래서 실습 데이터는 `--volume ~/nvdli-data:...`로 **호스트 폴더에 연결(마운트)**해서 컨테이너 밖에 남긴다.
- `--runtime nvidia`는 NVIDIA 컨테이너 런타임으로 **컨테이너 안에서도 젯슨의 GPU**를 쓸 수 있게 연결해준다.

### venv / 도커 / VM 격리 수준 비교

```
가벼움 ◀─────────────────────────────▶ 무거움
python venv        도커 컨테이너        가상머신(VM)
(파이썬 패키지만)   (OS 라이브러리까지)   (커널·OS 전체)
```

**과정**

1. DLI docker 설치 준비.
2. DLI docker이미지를 설치.
3. 카메라 연결과 동작까지 확인
4. 젯슨은 유선(이더넷) 또는 무선(WiFi)로 인터넷에 연결되어있어야합니다. 

---

# 2️⃣swap 설정 — ⚠️ 도커 실행 전에 먼저!
Jetson 보드에서 Docker 컨테이너를 실행할 때 발생하는 메모리 문제를 해결하기 위해 swap을 사용한다.
**특히 2GB 모델은 스왑 없이 도커 실습을 하면 반드시 멈추므로, 도커(3️⃣)보다 먼저 해야 한다.**

> 💡 **2GB vs 4GB** :
> - **2GB 모델** — 스왑이 **필수**. 없으면 모델 훈련 중 반드시 멈춘다. 아래 절차 전부 진행.
> - **4GB 모델** — 스왑이 **권장**. 기초 실습은 스왑 없이도 돌지만, 모델 훈련이나 CSI 카메라 사용 시
>   멈춤 방지를 위해 만들어 두는 것이 좋다. 절차는 동일. GUI를 계속 쓰고 싶다면
>   `set-default multi-user.target`(headless 전환) 단계는 건너뛰어도 된다.
>
> 💡 **크기는 8GB면 충분** — 실습 컨테이너는 `--memory-swap=4G` 옵션으로 스왑 사용량이 제한되므로
> 그보다 큰 스왑은 어차피 쓰이지 않는다. 특히 32GB SD 카드에서 스왑을 크게 잡으면
> 카드가 꽉 차서 도커 이미지 설치가 느려지거나 실패할 수 있으니 주의.

Jetson 보드는 메모리가 제한적이므로, Docker 컨테이너를 원활하게 실행하기 위해 
ZRAM을 비활성화하면 CPU 사용량을 줄이고, Docker 컨테이너가 더 많은 메모리를 사용할 수 있다

ZRAM을 비활성화하고, 스왑(Swap) 파일을 추가하는 작업을 수행하는 것

만약 Docker 컨테이너가 여러 개 실행될 경우, RAM이 부족하면 컨테이너가 충돌하거나 종료된다.

이를 방지하기 위해 스왑을 생성하여 가상 메모리를 추가하는 것

| 과정 | 이유 |
| --- | --- |
| ZRAM 비활성화 ```systemctl disable nvzramconfig```| CPU 사용량을 줄이고, 스왑을 직접 사용할 수 있도록 함 | 
| 스왑 파일 생성 ```fallocate -l 8G /mnt/8GB.swap``` | 메모리가 부족할 경우 추가적인 가상 메모리를 제공| 
| GUI 비활성화 ```systemctl set-default multi-user.target```| Docker 컨테이너 실행 시 GUI가 필요 없다면 RAM 사용량을 줄이기 위해 비활성화 |
| GUI 활성화| ```sudo systemctl set-default graphical.target```|


```multi-user.target```을 설정하면 GUI를 사용하지 않으므로 RAM 사용량이 줄어들기도 한다.


 **ZRAM 비활성화**

```
sudo systemctl disable nvzramconfig
```

## 스왑을 새로 만들고 싶다면

**① 스왑 파일 생성**
```
sudo fallocate -l 8G /mnt/8GB.swap
sudo chmod 600 /mnt/8GB.swap
sudo mkswap /mnt/8GB.swap
```

**② 부팅 시 자동 적용 — /etc/fstab에 등록**

한 번 등록해 두면 재부팅할 때마다 스왑이 자동으로 켜진다:

```
echo "/mnt/8GB.swap swap swap defaults 0 0" | sudo tee -a /etc/fstab
```

**③ 바로 적용 (재부팅 없이)**

```sudo swapon /mnt/8GB.swap```

**④ 정상 적용 확인**
```
free -h          # Swap 항목에 8.0G가 보이면 성공
swapon --show    # /mnt/8GB.swap 하나만 떠야 정상
```

**⑤ 시스템 재부팅**
```sudo reboot```

✅ 재부팅까지 끝났으면 스왑 준비 완료! 이제 아래 3️⃣에서 도커를 실행한다.

---

> [!NOTE]
> **아래 박스는 별개 과정입니다 — 처음 설정하는 사람은 열지 마세요!**
> 이미 다른 크기(예: 18GB)로 스왑을 만들었다가 크기를 바꾸고 싶은 경우에만 해당합니다.

<details>
<summary>🔧 <b>(선택) 기존 스왑을 삭제하고 크기를 바꾸고 싶다면 — 클릭해서 펼치기</b></summary>

<br>

예전에 18GB 등 다른 크기로 만들었던 스왑을 지우고 8GB로 다시 만들고 싶을 때.
아래는 18GB 스왑을 지우는 예시 — 파일명만 실제 만든 이름으로 바꾸면 된다.

**① 스왑 끄기**
```
swapon --show                  # 현재 스왑 파일 이름 확인
sudo swapoff /mnt/18GB.swap    # 끄는 데 몇 초 걸릴 수 있음
```

> ⚠️ `swapoff`가 "Cannot allocate memory" 오류로 실패하면, 스왑 내용을 램으로 되돌릴 공간이
> 없다는 뜻. 실행 중인 프로그램(도커 컨테이너 등)을 종료하고 재시도하거나,
> `sudo reboot` 후(부팅 직후엔 스왑 사용량이 거의 0) 다시 하면 된다.

**② 부팅 시 자동 적용 해제 — /etc/fstab에서 등록 삭제**
```
sudo sed -i '/18GB.swap/d' /etc/fstab
```

(`sed`가 낯설면 `sudo nano /etc/fstab`으로 열어 `18GB.swap`이 들어간 줄을 직접 지우고 저장해도 된다)

**③ 스왑 파일 삭제 — 디스크 공간이 바로 확보된다**
```
sudo rm /mnt/18GB.swap
df -h /          # SD 카드 여유 공간이 늘어났는지 확인
```

삭제가 끝났으면 위의 **"스왑을 새로 만들고 싶다면"** 절차대로 8GB 스왑을 만들면 된다.

</details>

---

---

# 3️⃣도커 실행 — 처음부터 스크립트로!

**⓪ 사전 점검 — 도커가 준비됐는지 확인 (⚠️ 호스트에서만!)**

아래 세 명령은 **젯슨나노 호스트 터미널**에서 실행한다.
(나중에 컨테이너 안에 들어간 상태에서 치면 "command not found"가 나온다 — 컨테이너 안에는 `docker` 명령이 없기 때문. 아래 [호스트 vs 컨테이너](#호스트-vs-컨테이너--지금-내가-어디에-있는지-구분하기) 참고)

```
docker --version                     # 도커 설치 확인
sudo systemctl status docker         # 도커 서비스 상태 확인 (active면 정상, 종료는 q)
sudo docker info | grep -i nvidia    # GPU 지원(nvidia 런타임) 확인
```

출력에 `nvidia` 런타임이 보이면 GPU 지원 준비 완료.

> ⚠️ 참고: PC용 문서에 나오는 `nvidia-smi` 명령은 **젯슨에서는 동작하지 않는다**
> (Tegra 계열엔 nvidia-smi가 없음). 젯슨에서 GPU 상태 확인은 `jtop`을 사용한다.

**① 데이터 폴더 만들기** (실습 결과가 컨테이너 밖에 남는 곳):

```mkdir -p ~/nvdli-data```

**② 실행 스크립트 `docker_dli_run.sh` 만들기 (한 번만)**

도커 실행 명령이 매우 길기 때문에, 직접 치지 말고 **처음부터 스크립트 파일로 저장**해서 사용한다.
아래 `echo "..." > docker_dli_run.sh`는 따옴표 안의 긴 도커 명령을 파일로 저장하는 명령이다.
**내 모델(2GB/4GB)에 맞는 것 하나만** 실행하면 된다:

### 💡 2GB 모델은 스크립트를 이렇게 만든다

```
echo "sudo docker run --runtime nvidia -it --rm --network host \
    --memory=500M --memory-swap=4G \
    --volume ~/nvdli-data:/nvdli-nano/data \
    --volume /tmp/argus_socket:/tmp/argus_socket \
    --device /dev/video0 \
    nvcr.io/nvidia/dli/dli-nano-ai:v2.0.2-r32.7.1kr" > docker_dli_run.sh

chmod +x docker_dli_run.sh    # 실행 권한 부여
```

### 💡 4GB 모델(일반 젯슨나노)은 스크립트를 이렇게 만든다

`--memory=500M --memory-swap=4G`는 램이 부족한 2GB에서 컨테이너의 메모리 사용을
강제로 제한하는 옵션이므로, **4GB 모델은 이 두 옵션을 뺀 스크립트**를 만든다
(NVIDIA 공식 DLI 문서의 4GB용 명령과 동일):

```
echo "sudo docker run --runtime nvidia -it --rm --network host \
    --volume ~/nvdli-data:/nvdli-nano/data \
    --volume /tmp/argus_socket:/tmp/argus_socket \
    --device /dev/video0 \
    nvcr.io/nvidia/dli/dli-nano-ai:v2.0.2-r32.7.1kr" > docker_dli_run.sh

chmod +x docker_dli_run.sh
```

| | 2GB 모델 | 4GB 모델 |
| --- | --- | --- |
| 메모리 제한 옵션 | `--memory=500M --memory-swap=4G` **필수** | **생략** (제한 없이 사용) |
| 컨테이너 이미지 | 동일 (`dli-nano-ai:v2.0.2-r32.7.1kr`) | 동일 |
| 실행 방법 | `./docker_dli_run.sh` | `./docker_dli_run.sh` (동일) |

**③ 실행 — 이제부터는 언제나 이 한 줄뿐!**

```
./docker_dli_run.sh
```

처음 한 번은 이미지를 다운로드하므로 시간이 제법 걸린다. (와이파이가 끊기면 다시 실행)

## 스크립트 안에 들어있는 도커 명령 옵션 설명

|옵션|설명|
| --- | --- |
|sudo docker run|새로운 컨테이너를 실행|
|--runtime nvidia|NVIDIA GPU를 사용할 수 있도록 설정|
|-it|인터랙티브(터미널에서 사용 가능) 모드|
|--rm|컨테이너 종료 시 자동 삭제|
|--network host|호스트 네트워크 사용 (Jetson Nano의 네트워크를 직접 사용)|
|--volume ~/nvdli-data:/nvdli-nano/data	|호스트의 ~/nvdli-data 폴더를 컨테이너 내 /nvdli-nano/data로 마운트|
|--volume /tmp/argus_socket:/tmp/argus_socket|**CSI 카메라**용 소켓 마운트 (USB 카메라만 쓴다면 없어도 되지만 넣어둬서 두 카메라 모두 지원)|
|--device /dev/video0|Jetson Nano의 카메라 장치(USB/CSI 공통)를 컨테이너에서 사용할 수 있도록 설정|
|nvcr.io/nvidia/dli/dli-nano-ai:v2.0.2-r32.7.1kr|NVIDIA에서 제공하는 AI 실습 컨테이너 이미지|

![](../img/doker.png)

---

# 4️⃣컨테이너 들어가기 / 나오기

## 호스트 vs 컨테이너 — 지금 내가 어디에 있는지 구분하기

같은 터미널 창이라도 **호스트(젯슨나노 본체)**와 **컨테이너 안**은 완전히 다른 환경이다.
**프롬프트 모양**을 보면 지금 어디에 있는지 바로 알 수 있다:

| | 호스트 (젯슨나노) | 컨테이너 안 |
| --- | --- | --- |
| 프롬프트 예시 | `dli@nano-desktop:~$` | `root@nano-desktop:/nvdli-nano#` |
| 구분 포인트 | **내 계정 이름**으로 시작, 끝이 `$` | **root**로 시작, 끝이 `#`, 경로가 `/nvdli-nano` |
| 쓸 수 있는 명령 | `docker`, `systemctl`, `jtop`, 스왑 설정 등 | 실습용 파이썬/주피터 관련만 |
| 안 되는 명령 | — | `docker`, `systemctl`, `jtop` → **command not found** |

> 💡 컨테이너 안은 격리된 별도 환경이라 호스트의 프로그램이 없다.
> "건물 안 방에서 건물 전체의 전기 배전반을 찾는" 상황과 같다.
> 도커 관련 확인·관리는 항상 **호스트에서** 한다 (위 ⓪ 사전 점검 참고).

## 컨테이너 들어가기

호스트에서:

```
./docker_dli_run.sh
```

**들어가면 이렇게 보인다:**

1. 프롬프트가 `root@...:/nvdli-nano#` 모양으로 바뀐다 — 이제 컨테이너 안이다.
2. `ls`를 쳐보면 컨테이너 안 구조가 보인다:
   - `/nvdli-nano/data` — 호스트의 `~/nvdli-data`와 연결된 폴더. **여기 저장한 것만 컨테이너 종료 후에도 남는다.**
   - 실습 노트북 폴더들 (`hello_camera`, `classification`, `regression` 등)
3. JupyterLab 서버는 **자동으로 이미 실행 중**이다 — 컨테이너 안에서 뭘 더 켤 필요 없다.
   컴퓨터(노트북) 브라우저에서 `http://<젯슨나노IP>:8888` 접속, 비밀번호 `dlinano`.

**컨테이너 안에서 상태 점검이 필요할 때:**

```
free -h          # 메모리/스왑 상태 (컨테이너 안에서도 동작)
ls /dev/video0   # 카메라 장치가 컨테이너에 연결됐는지 확인
```

## 컨테이너 나오기

컨테이너 안 프롬프트에서:

```
exit             # 또는 Ctrl+D
```

**나오면 이렇게 된다:**

1. 프롬프트가 `dli@nano-desktop:~$` 모양(내 계정)으로 돌아온다 — 다시 호스트다.
2. 우리 스크립트에 `--rm` 옵션이 있어서 **컨테이너는 종료와 동시에 삭제**된다. JupyterLab도 같이 꺼진다.
3. 하지만 실습 데이터는 `~/nvdli-data`(= 컨테이너의 `/nvdli-nano/data`)에 마운트되어 있으므로 **지워지지 않는다.**
4. 다시 실습하려면 `./docker_dli_run.sh` 한 줄이면 된다. (이미지는 이미 받아져 있어서 이번엔 금방 뜬다)

> 💡 **실습을 유지한 채 호스트 명령을 쓰고 싶다면?**
> 컨테이너에서 나오지 말고, **터미널 창을 하나 더 열거나** 노트북에서 SSH로 한 번 더
> 접속(`ssh dli@<젯슨나노IP>`)해서 거기서 호스트 명령을 실행하면 된다.
> 컨테이너는 그대로 돌아가고 JupyterLab도 안 끊긴다.


![](../img/jupyter.png)

# 5️⃣jupyter notebook 사용하기
*http://192.168.***.***:8888 (password dlinano)*

화면에 나온 ip주소를 브라우저로 연결한다

password는 보통 dlinano 라고 알려준다.

![](../img/008.png)   

## thumn up and thumn down
여기서 **classification** 을 선택해서 들어간다

![](../img/009.png)  

[4_classification_interactive.ipynb](./4_classification_interactive.ipynb)

---

[🙋‍♂️ 5.next thumbs up down ](./4_classification_interactive.ipynb)

[🙋‍♂️ 6.next arduino for jetson](../03_arduino_sensor/arduino_sensor_for_jetson.md)

