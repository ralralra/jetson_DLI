# 3️⃣ USB 포트 찾기 — 리더암과 팔로워암의 "번호표" 알아내기

## 🎯 이 단계의 목표
- 리더암과 팔로워암이 각각 몇 번 **COM 포트**에 연결되었는지 알아낸다.
- 알아낸 번호를 **my_settings.bat** 파일에 적어 두고, 매번 한 줄로 불러올 수 있다.

## 🤔 왜 필요한가?
PC에 팔 두 개를 USB로 꽂으면 윈도우는 각각에 `COM3`, `COM4` 같은 **번호표**를 붙인다. 하지만 어느 쪽이 리더이고 어느 쪽이 팔로워인지는 알려 주지 않는다.
LeRobot에게 "팔로워는 COM4야"라고 정확히 알려 주지 않으면, 엉뚱한 팔에 명령을 보내게 된다.
가장 확실한 방법은 **"꽂혀 있을 때 목록"과 "뽑았을 때 목록"을 비교**하는 것이다. 사라진 번호가 바로 방금 뽑은 팔의 번호다.

---

## 1. 준비
1. 두 팔 모두 **전원 어댑터**를 꽂는다.
2. 두 팔 모두 **USB 케이블로 PC에 연결**한다.
3. Miniforge Prompt에서 시작 주문을 입력한다.

```bat
conda activate lerobot
cd /d C:\robot\lerobot
```

---

## 2. 팔로워암 포트 찾기

```bat
lerobot-find-port
```

📖 **이 명령은?** 지금 PC에 연결된 모든 COM 포트 목록을 보여 준 뒤, USB를 하나 뽑으라고 안내한다. 뽑은 뒤 Enter를 누르면 **사라진 포트 = 그 팔의 포트**를 알려 준다.

화면 진행 예시:
```
Finding all available ports for the MotorsBus.
Ports before disconnecting: ['COM3', 'COM4']
Remove the USB cable from your MotorsBus and press Enter when done.
```
👉 이때 **팔로워암(흰 팔)의 USB 케이블만** PC에서 뽑고 **Enter** 를 누른다.

```
The port of this MotorsBus is 'COM4'
Reconnect the USB cable.
```
👉 팔로워암 = **COM4** (예시). 종이에 적고, 뽑았던 USB를 **같은 USB 구멍에** 다시 꽂는다.

## 3. 리더암 포트 찾기
같은 명령을 한 번 더 실행하고, 이번에는 **리더암(검은 팔)의 USB만** 뽑는다.

```bat
lerobot-find-port
```

| 팔 | 내 포트 번호 |
|---|---|
| 팔로워암 (Follower) | COM____ |
| 리더암 (Leader) | COM____ |

> ⚠️ **Enter를 누르기 전에 반드시 USB를 뽑아야 한다.** 안 뽑고 Enter를 누르면 `Could not detect the port. No difference was found` 오류가 난다. 다시 실행하면 된다.
> 💡 윈도우는 보통 **같은 장치를 같은 USB 구멍에 꽂으면 같은 번호**를 준다. 다른 구멍에 꽂으면 번호가 바뀔 수 있으니, USB 구멍에 스티커로 "리더", "팔로워"라고 붙여 두자.
> 💡 장치 관리자 → 포트(COM & LPT) 에서도 번호를 볼 수 있다. 하나씩 뽑아 보며 사라지는 항목을 확인하는 것과 같은 원리다.

---

## 4. my_settings.bat — 내 설정을 한 파일에 저장하기

앞으로 거의 모든 명령에 포트 번호와 팔 이름이 들어간다. 매번 `COM4` 를 손으로 치면 실수하기 쉽다.
그래서 **"변수"** 라는 메모지를 만들어 둔다. `FOLLOWER_PORT` 라는 메모지에 `COM4` 를 적어 두면, 명령에서 `%FOLLOWER_PORT%` 라고 쓰는 순간 `COM4` 로 바뀌어 들어간다.

### 4-1. 파일 만들기
1. 이 저장소의 [my_settings.bat](./my_settings.bat) 내용을 복사한다.
2. **메모장**을 열고 붙여넣는다.
3. `COM4`, `COM3` 부분을 **내가 찾은 번호로** 고친다.
4. **파일 → 다른 이름으로 저장** → 위치 `C:\robot`, 파일 이름 `my_settings.bat`, 파일 형식 **모든 파일(*.*)** 로 저장한다.
   - 파일 형식을 "텍스트 문서"로 두면 `my_settings.bat.txt` 가 되어 실행되지 않는다!

### 4-2. 실행하기 (매번 실습 시작할 때)
Miniforge Prompt를 열고:

```bat
C:\robot\my_settings.bat
```

📖 **이 명령은?** bat 파일 안에 적힌 명령들을 위에서부터 차례로 실행한다. 이 파일은 ① `lerobot` 가상환경에 들어가고 ② `C:\robot\lerobot` 폴더로 이동하고 ③ 포트·이름 변수를 만든 뒤 ④ 설정값을 화면에 보여 준다.
즉 **"시작 주문"을 한 줄로 줄여 주는 파일**이다.

```
========================================
 FOLLOWER_PORT = COM4    FOLLOWER_ID = my_follower
 LEADER_PORT   = COM3    LEADER_ID   = my_leader
========================================
```
이렇게 나오면 준비 완료다.

### 4-3. 변수가 잘 들어갔는지 확인
```bat
echo %FOLLOWER_PORT%
```
📖 `echo` 는 뒤의 내용을 화면에 그대로 출력한다. `COM4` 가 나오면 성공, `%FOLLOWER_PORT%` 가 그대로 나오면 bat 파일을 아직 실행하지 않은 것이다.

> ⚠️ 변수는 **그 창에서만** 살아 있다. 창을 닫았다가 새로 열면 다시 `C:\robot\my_settings.bat` 을 실행해야 한다.
> 💡 변수를 쓰기 싫다면, 이후 명령의 `%FOLLOWER_PORT%` 자리에 `COM4` 처럼 직접 써도 똑같이 동작한다.

---

## ✅ 체크리스트
- [ ] 팔로워암·리더암의 COM 번호를 적었다.
- [ ] `C:\robot\my_settings.bat` 을 만들었다.
- [ ] `echo %FOLLOWER_PORT%` 가 내 포트 번호를 보여 준다.

➡️ 다음:
- 직접 조립하는 키트라면 → [04_모터_ID_설정.md](./04_모터_ID_설정.md)
- **조립 완성품**을 받았다면 → [06_캘리브레이션.md](./06_캘리브레이션.md)
