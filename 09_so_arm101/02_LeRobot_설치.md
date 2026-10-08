# 2️⃣ LeRobot 설치 — 가상환경 만들고 프로그램 내려받기

## 🎯 이 단계의 목표
- LeRobot 전용 **가상환경 `lerobot`** 을 만들고 들어갈 수 있다.
- LeRobot **v0.6.1** 을 내려받아 설치한다.
- 설치가 잘 됐는지 스스로 확인할 수 있다.

## 🤔 왜 이렇게 하나?
1단계에서 말한 "개인 주방"을 실제로 차리는 단계이다.
- **가상환경**: 파이썬 3.12와 LeRobot 부품만 들어 있는 독립된 방. 망가지면 지우고 다시 만들면 그만이다.
- **소스코드 내려받기(git clone)**: LeRobot 설계도 전체를 내 PC로 복사한다. 예제 파일과 설정을 직접 볼 수 있어 공부에 좋다.
- **버전 고정(v0.6.1)**: LeRobot은 거의 매주 바뀐다. 오늘 되는 명령이 다음 달엔 이름이 바뀔 수 있어서, 이 교재와 똑같은 버전으로 맞춘다.

> ⏱️ 인터넷 속도에 따라 30분~1시간 걸린다. 내려받는 양이 수 GB이므로 학교 와이파이보다 유선 인터넷이 좋다.

---

## 1. 가상환경 만들기

**Miniforge Prompt** 를 열고 차례대로 입력한다.

```bat
conda create -y -n lerobot python=3.12
```

📖 **이 명령은?** `lerobot` 이라는 이름(`-n lerobot`)의 새 가상환경을 만들고, 그 안에 **파이썬 3.12** 를 설치한다. `-y` 는 "설치할까요? (y/n)" 질문에 미리 "예"라고 답하는 옵션이다.
> 왜 3.12인가? LeRobot 0.6 버전부터 파이썬 3.12 이상만 지원한다. (예전 자료의 3.10은 이제 안 된다.)

```bat
conda activate lerobot
```

📖 **이 명령은?** 방금 만든 `lerobot` 가상환경 **안으로 들어간다.** 줄 맨 앞이 `(base)` → `(lerobot)` 으로 바뀌면 성공이다.

> 🚨 **가장 많이 하는 실수!** Miniforge Prompt를 새로 열 때마다 `(base)` 상태로 시작한다.
> **창을 열 때마다 `conda activate lerobot` 을 먼저 입력**해야 한다. 이걸 빼먹으면 `'lerobot-xxx'은(는) 내부 또는 외부 명령...이 아닙니다` 오류가 난다.

---

## 2. 도구 설치 — git, ffmpeg

```bat
conda install -y -c conda-forge git ffmpeg
```

📖 **이 명령은?** 가상환경 안에 두 가지 도구를 설치한다. `-c conda-forge` 는 "conda-forge라는 창고에서 가져와"라는 뜻이다.

| 도구 | 하는 일 | 왜 필요한가 |
|---|---|---|
| **git** | 인터넷 저장소(GitHub)의 코드를 내려받고 버전을 바꾸는 프로그램 | LeRobot 코드를 받기 위해 |
| **ffmpeg** | 동영상을 압축·재생하는 프로그램 | 녹화한 카메라 영상을 저장·학습할 때 |

확인:
```bat
git --version
ffmpeg -version
```
📖 각각 버전 숫자가 나오면 설치 성공이다. (`ffmpeg` 는 `-version` 에 하이픈이 하나다.)

---

## 3. LeRobot 소스코드 내려받기

```bat
cd /d C:\robot
git clone https://github.com/huggingface/lerobot.git
cd lerobot
```

📖 **이 명령은?**
- `cd /d C:\robot` : 1단계에서 만든 작업 폴더로 이동한다.
- `git clone 주소` : GitHub에 있는 LeRobot 저장소 전체를 `C:\robot\lerobot` 폴더로 **복제**한다.
- `cd lerobot` : 복제된 폴더 안으로 들어간다.

```bat
git checkout v0.6.1
```

📖 **이 명령은?** 내려받은 코드 중에서 **v0.6.1 버전 시점**으로 되돌린다. 마치 책의 "개정 3판"을 골라 펴는 것과 같다.
`You are in 'detached HEAD' state ...` 라는 긴 영어 안내가 나오는데, **정상이다.** "특정 버전을 보고 있다"는 뜻일 뿐 오류가 아니다.

---

## 4. PyTorch 설치 (NVIDIA 그래픽카드가 있는 경우만)

> 1단계에서 `nvidia-smi` 가 **안 나왔다면 이 4번을 건너뛰고 5번으로** 간다.

```bat
pip install torch==2.11.0 torchvision==0.26.0 --index-url https://download.pytorch.org/whl/cu128
```

📖 **이 명령은?** AI 계산 엔진인 **PyTorch** 를 **그래픽카드(CUDA 12.8)용**으로 설치한다.
- `pip install` : 파이썬 부품을 설치하는 명령.
- `--index-url .../cu128` : 기본 창고 대신 **PyTorch 공식 GPU 전용 창고**에서 받으라는 뜻.
- **왜 따로 설치하나?** 윈도우에서 그냥 설치하면 **CPU 전용 PyTorch** 가 깔린다. 그러면 GPU가 있어도 학습이 CPU로만 돌아가 수십 배 느리다. 그래서 GPU용을 **먼저** 깔아 두면 5번에서 LeRobot이 이를 그대로 사용한다.
- 2.11.0 버전은 LeRobot v0.6.1이 시험한 버전과 같다. 2GB 이상 내려받으므로 시간이 걸린다.

> 💡 `nvidia-smi` 에 나온 `CUDA Version` 이 **12.8보다 낮으면** 그래픽 드라이버를 최신으로 업데이트한 뒤 진행한다.

---

## 5. LeRobot 설치

`C:\robot\lerobot` 폴더 안에 있는지 확인(`(lerobot) C:\robot\lerobot>`)한 뒤 입력한다.

```bat
pip install -e ".[feetech,core_scripts,training]"
```

📖 **이 명령은?** 현재 폴더(`.`)의 LeRobot을 설치하면서 꼭 필요한 **추가 부품 묶음(extras)** 3가지를 함께 설치한다.

| 묶음 | 들어 있는 것 | 왜 필요한가 |
|---|---|---|
| `feetech` | Feetech 모터 통신 프로그램, 시리얼 통신(pyserial) | SO-101의 STS3215 모터가 Feetech 제품이라서 |
| `core_scripts` | 데이터셋 도구, 키보드 입력(pynput), 화면 표시(rerun) | 캘리브레이션·녹화·재생 명령을 쓰기 위해 |
| `training` | 학습 가속(accelerate), 학습 그래프(wandb) | AI 학습을 하기 위해 |

- `-e` (editable) : 코드를 복사하지 않고 **이 폴더를 그대로 연결**해서 설치한다. 나중에 코드를 열어 보거나 고치면 바로 반영된다.
- 따옴표 `"..."` 는 대괄호 `[ ]` 가 섞인 글자를 한 덩어리로 읽게 해 준다. 빼먹지 말자.

> ⏱️ 수십 개 부품을 받으므로 10~30분 걸린다. 빨간 `WARNING` 은 대부분 무시해도 되지만, 마지막 줄이 `ERROR` 로 끝나면 [12_문제해결.md](./12_문제해결.md) 를 본다.

---

## 6. 설치 확인

### 6-1. LeRobot 명령어 확인
```bat
lerobot-info
```
📖 **이 명령은?** 설치된 LeRobot 버전, 파이썬 버전, PyTorch 버전, GPU 사용 가능 여부 등 **환경 정보를 한 번에 출력**한다. 오류 없이 표가 나오면 성공이다.

### 6-2. GPU 연결 확인 (GPU가 있는 경우)
```bat
python -c "import torch; print(torch.__version__, torch.cuda.is_available())"
```
📖 **이 명령은?** 파이썬에게 한 줄짜리 코드를 바로 실행시킨다(`-c`). PyTorch 버전과 "GPU를 쓸 수 있는가?"를 출력한다.

| 결과 | 의미 |
|---|---|
| `2.11.0+cu128 True` | ✅ GPU로 학습 가능 |
| `2.11.0+cpu False` | GPU용이 아닌 CPU용이 깔림 → 4번 명령에 `--force-reinstall` 을 붙여 다시 실행 |
| `... False` (GPU 없는 PC) | 정상. 학습은 Colab에서 한다 |

---

## 🔁 다음부터 실습을 시작할 때마다 (매번!)

```bat
conda activate lerobot
cd /d C:\robot\lerobot
```

📖 가상환경에 들어가고(`activate`), LeRobot 폴더로 이동한다. **모든 실습의 시작 주문**이라고 생각하자.

---

## ✅ 체크리스트
- [ ] 줄 앞에 `(lerobot)` 이 보인다.
- [ ] `C:\robot\lerobot` 폴더가 있다.
- [ ] `lerobot-info` 가 오류 없이 실행된다.
- [ ] (GPU PC) `torch.cuda.is_available()` 이 `True` 이다.

➡️ 다음: [03_USB_포트_찾기.md](./03_USB_포트_찾기.md)
