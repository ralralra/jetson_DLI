# 2️⃣ 초기 설정 ② — 가상환경 만들고 LeRobot 설치하기

## 🎯 이 단계의 목표
- LeRobot 전용 **가상환경 `lerobot`** 을 만들고 켤 수 있다.
- LeRobot **v0.6.1** 을 내려받아 설치하고, 잘 됐는지 확인한다.

## 🤔 왜 가상환경을 따로 만드나?
가상환경은 **LeRobot만을 위한 독립된 방**이다. 파이썬 3.12와 LeRobot 부품만 들어 있어서, PC의 다른 파이썬 프로그램과 버전이 엉키지 않는다. 망가지면 지우고 다시 만들면 그만이다.

> 📌 1단계를 마쳐서 VS Code 터미널이 `(base) PS C:\robot>` 인 상태에서 시작한다. 명령은 **한 줄씩** 붙여넣는다.

---

## 1단계. 가상환경 만들고 켜기 (Python 3.12)

```powershell
conda create -y -n lerobot python=3.12
```
📖 **이 명령은?** `lerobot` 이라는 이름의 가상환경을 만들고 그 안에 파이썬 3.12를 설치한다. `-y` 는 "설치할까요?" 질문에 미리 "예"라고 답하는 옵션이다.
> 왜 3.12인가? LeRobot 0.6 버전부터 파이썬 3.12 이상만 지원한다. 예전 자료의 3.10은 이제 안 된다.

```powershell
conda activate lerobot
```
📖 **이 명령은?** 방금 만든 가상환경 **안으로 들어간다.** 프롬프트가 `(lerobot) PS C:\robot>` 으로 바뀌면 성공이다.

확인:
```powershell
python -c "import sys; print(sys.executable)"
```
📖 지금 쓰고 있는 파이썬의 위치를 출력한다. 결과에 **`envs\lerobot`** 이 들어 있으면 가상환경의 파이썬이 맞다.

---

## 2단계. git, ffmpeg 설치

```powershell
conda install -y git ffmpeg -c conda-forge
```
📖 **이 명령은?** 가상환경 안에 두 도구를 설치한다.
- **git**: GitHub에서 코드를 내려받고 버전을 고르는 프로그램 (다음 단계에서 사용)
- **ffmpeg**: 동영상을 압축·재생하는 프로그램 (카메라 녹화 영상 저장·학습에 사용)

> 💡 PC에 git이 이미 있어도 이렇게 설치해 두면 `'git' 용어가 ... 인식되지 않습니다` 오류를 미리 막을 수 있다.

---

## 3단계. LeRobot 소스 받기 (v0.6.1로 고정)

```powershell
git clone https://github.com/huggingface/lerobot.git
```
📖 GitHub의 LeRobot 저장소 전체를 `C:\robot\lerobot` 폴더로 복제한다.

```powershell
cd lerobot
```
📖 복제한 폴더 안으로 들어간다. 프롬프트가 `(lerobot) PS C:\robot\lerobot>` 이 된다.

```powershell
git checkout v0.6.1
```
📖 **이 명령은?** 이 교재가 검증한 **v0.6.1 버전**으로 맞춘다. LeRobot은 거의 매주 바뀌어서, 최신 코드에서는 이 교재의 명령 이름이 다를 수 있기 때문이다.
`You are in 'detached HEAD' state` 라는 긴 영어 안내는 **오류가 아니다.** "특정 버전을 보고 있다"는 뜻이다.

---

## 4단계. (NVIDIA 그래픽카드가 있는 PC만) GPU용 PyTorch 먼저 설치

그래픽카드가 있는지 확인:
```powershell
nvidia-smi
```
- 표가 나오면 → 아래 명령을 실행한다.
- `'nvidia-smi' 용어가 ... 인식되지 않습니다` → GPU가 없는 PC이다. **이 4단계를 건너뛴다.** (학습은 10단계에서 Colab으로 한다.)

```powershell
pip install torch==2.11.0 torchvision==0.26.0 --index-url https://download.pytorch.org/whl/cu128
```
📖 **이 명령은?** AI 계산 엔진 **PyTorch** 를 **그래픽카드용**으로 설치한다.
그냥 LeRobot을 설치하면 윈도우에서는 **CPU 전용 PyTorch** 가 깔려서, GPU가 있어도 학습이 수십 배 느려진다. 그래서 GPU용을 **먼저** 깔아 둔다. 2GB 이상이라 시간이 걸린다.

---

## 5단계. LeRobot 설치 (SO-101용)

`(lerobot) PS C:\robot\lerobot>` 위치인지 확인하고 실행한다.

```powershell
pip install -e ".[core_scripts,feetech,training]"
```
📖 **이 명령은?** 현재 폴더(`.`)의 LeRobot을 설치하면서 추가 부품 묶음 3가지를 함께 설치한다.

| 묶음 | 왜 필요한가 |
|---|---|
| `core_scripts` | 캘리브레이션·녹화·재생 명령, 화면 표시(rerun), 키보드 입력 |
| `feetech` | SO-101의 STS3215 모터가 **Feetech** 제품이라 그 통신 프로그램이 필요 |
| `training` | AI 학습(10단계)에 필요한 부품 |

- `-e` 는 코드를 복사하지 않고 이 폴더를 그대로 연결해서 설치한다는 뜻이다.
- 따옴표 `"..."` 를 빼먹으면 PowerShell이 대괄호를 잘못 읽어 오류가 난다.
- 10~30분 걸린다. 노란 `WARNING` 은 대부분 무시해도 되지만, 마지막 줄이 빨간 `ERROR` 면 아래 문제 해결을 본다.

---

## 6단계. 설치 확인

```powershell
python -c "import lerobot, torch; print('lerobot OK', torch.__version__, 'CUDA:', torch.cuda.is_available())"
```
📖 LeRobot과 PyTorch를 불러와서 버전과 GPU 사용 가능 여부를 출력한다.

| 결과 | 의미 |
|---|---|
| `lerobot OK 2.11.0+cu128 CUDA: True` | ✅ GPU까지 완벽 |
| `lerobot OK 2.11.0+cpu CUDA: False` (GPU 없는 PC) | ✅ 정상. 학습은 Colab으로 |
| `lerobot OK 2.11.0+cpu CUDA: False` (GPU 있는 PC) | 4단계 명령 끝에 ` --force-reinstall` 을 붙여 다시 실행 |

```powershell
lerobot-info
```
📖 LeRobot 명령어가 제대로 등록되었는지 확인한다. LeRobot·파이썬·PyTorch 버전 등 환경 정보가 오류 없이 나오면 성공이다.

---

## 7단계. VS Code 인터프리터 지정

`Ctrl + Shift + P` → **Python: Select Interpreter** → **Python 3.12 ('lerobot')** 선택.

📖 VS Code의 코드 편집기와 노트북이 `lerobot` 가상환경의 파이썬을 쓰도록 지정한다. (터미널 명령에는 영향이 없다. 터미널은 `conda activate lerobot` 으로 정한다.)
> 목록에 안 보이면 VS Code에 **Python 확장(Microsoft)** 이 설치되어 있는지 확인한다.

---

## 📌 다음에 다시 작업할 때 (매번!)

VS Code를 켜고 터미널에서 이 두 줄만 실행한다.
```powershell
conda activate lerobot
```
```powershell
cd C:\robot\lerobot
```
프롬프트가 `(lerobot) PS C:\robot\lerobot>` 이면 준비 완료다. **이후 모든 단계는 이 상태에서 시작한다.**

### 자주 쓰는 conda 명령

| 하고 싶은 것 | 명령 |
|---|---|
| 가상환경 켜기 | `conda activate lerobot` |
| 가상환경 끄기 | `conda deactivate` |
| 가상환경 목록 (`*` = 현재 켜진 환경) | `conda env list` |
| 지금 어떤 파이썬인지 확인 | `python -c "import sys; print(sys.executable)"` |

---

## 🛠 문제 해결

| 증상 / 오류 메시지 | 원인 / 해결 |
|---|---|
| `conda activate lerobot` 을 쳐도 `(lerobot)` 이 안 붙음 | PowerShell과 conda 연결 문제 → [01_프로그램_설치.md](./01_프로그램_설치.md) 3·4단계 |
| `EnvironmentNameNotFound: Could not find conda environment: lerobot` | 가상환경이 아직 없다 → 1단계 `conda create` 실행 |
| `'git' 용어가 ... 인식되지 않습니다` | 2단계 git 설치를 빠뜨림, 또는 `(lerobot)` 밖에서 실행 |
| `fatal: destination path 'lerobot' already exists` | 이미 받아 둔 폴더가 있다 → `cd lerobot` 후 `git checkout v0.6.1` 만 실행 |
| `ERROR: Package 'lerobot' requires a different Python` | 가상환경 밖이거나 파이썬이 3.12 미만 → `conda activate lerobot` 후 다시 |
| `Microsoft Visual C++ 14.0 or greater is required` | 일부 부품 빌드 도구가 없다 → "Visual Studio Build Tools" 설치 시 **C++를 사용한 데스크톱 개발** 선택 후 다시 |
| `'lerobot-info' 용어가 ... 인식되지 않습니다` | `(lerobot)` 밖이거나 5단계가 실패함 → `conda activate lerobot` 후 5단계 다시 |
| `3 channel Terms of Service accepted` | 오류 아님. Anaconda 약관 안내라서 무시 |
| pip 설치 중 네트워크 오류(`ReadTimeout` 등) | 같은 명령을 다시 실행하면 받다 만 곳부터 이어서 받는다 |

### 처음부터 다시 하고 싶을 때 (최후의 방법)
```powershell
conda deactivate
```
```powershell
conda remove -y -n lerobot --all
```
📖 `lerobot` 가상환경을 통째로 지운다. 이후 1단계부터 다시 한다. (`C:\robot\lerobot` 코드 폴더와 캘리브레이션·녹화 데이터는 지워지지 않는다.)

---

## ✅ 체크리스트
- [ ] 프롬프트가 `(lerobot) PS C:\robot\lerobot>` 이다.
- [ ] 6단계에서 `lerobot OK` 가 나왔다.
- [ ] VS Code 인터프리터를 `lerobot` 으로 지정했다.

➡️ 다음: [03_USB_포트_찾기.md](./03_USB_포트_찾기.md)
