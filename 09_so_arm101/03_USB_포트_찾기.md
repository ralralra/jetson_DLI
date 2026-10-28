# 3️⃣ USB 포트 찾기 — 리더암과 팔로워암의 "번호표" 알아내기

## 🎯 이 단계의 목표
- 리더암과 팔로워암이 각각 몇 번 **COM 포트**에 연결되었는지 알아낸다.

## 🤔 왜 필요한가?
PC에 팔 두 개를 USB로 꽂으면 윈도우는 각각에 `COM3`, `COM4` 같은 **번호표**를 붙인다. 하지만 어느 쪽이 리더이고 어느 쪽이 팔로워인지는 알려 주지 않는다.
가장 확실한 방법은 **"꽂혀 있을 때 목록"과 "뽑았을 때 목록"을 비교**하는 것이다. 사라진 번호가 바로 방금 뽑은 팔의 번호다.

---

## 1. 준비
1. 두 팔 모두 **전원 어댑터**를 꽂는다.
2. 두 팔 모두 **USB 케이블로 PC에 연결**한다.
3. VS Code 터미널이 `(lerobot) PS C:\robot\lerobot>` 인지 확인한다. 아니라면:

```powershell
conda activate lerobot
```
```powershell
cd C:\robot\lerobot
```

---

## 2. 팔로워암 포트 찾기

```powershell
lerobot-find-port
```

📖 **이 명령은?** 지금 연결된 모든 COM 포트 목록을 보여 준 뒤, USB를 하나 뽑으라고 안내한다. 뽑은 뒤 Enter를 누르면 **사라진 포트 = 그 팔의 포트**를 알려 준다.

```
Finding all available ports for the MotorsBus.
Ports before disconnecting: ['COM3', 'COM4']
Remove the USB cable from your MotorsBus and press Enter when done.
```
👉 이때 **팔로워암(흰 팔)의 USB 케이블만** PC에서 뽑고 **Enter**.

```
The port of this MotorsBus is 'COM3'
Reconnect the USB cable.
```
👉 팔로워암 = **COM3** (예시). 적어 두고, 뽑았던 USB를 **같은 USB 구멍에** 다시 꽂는다.

## 3. 리더암 포트 찾기
같은 명령을 한 번 더 실행하고, 이번에는 **리더암(검은 팔)의 USB만** 뽑는다.

```powershell
lerobot-find-port
```

| 팔 | 내 포트 번호 |
|---|---|
| 팔로워암 (Follower) | COM____ |
| 리더암 (Leader) | COM____ |

---

## 4. ✏️ 이후 명령에서 포트 번호 바꿔 쓰기

이 교재의 명령은 **팔로워 = `COM3`, 리더 = `COM4`** 를 예시로 쓴다.
내 번호가 다르면 명령을 붙여넣은 뒤 **Enter 전에** 숫자만 고친다. 메모장에 명령을 미리 붙여 고쳐 두고 복사해 쓰면 편하다.

| 명령 속 글자 | 뜻 | 바꿀 것 |
|---|---|---|
| `--robot.port=COM3` | 팔로워암 포트 | 내 팔로워 포트 |
| `--teleop.port=COM4` | 리더암 포트 | 내 리더 포트 |
| `--robot.id=my_follower` | 팔로워암 이름 | 바꾸지 않는다 |
| `--teleop.id=my_leader` | 리더암 이름 | 바꾸지 않는다 |

> ⚠️ **Enter를 누르기 전에 반드시 USB를 뽑아야 한다.** 안 뽑고 Enter를 누르면 `Could not detect the port. No difference was found` 오류가 난다. 다시 실행하면 된다.
> 💡 윈도우는 보통 **같은 장치를 같은 USB 구멍에 꽂으면 같은 번호**를 준다. USB 구멍에 스티커로 "리더", "팔로워"라고 붙여 두면 다음 수업에서 다시 찾지 않아도 된다.
> 💡 장치 관리자 → 포트(COM & LPT) 에서도 번호를 볼 수 있다.

---

## ✅ 체크리스트
- [ ] 팔로워암·리더암의 COM 번호를 적었다.
- [ ] USB 구멍에 리더/팔로워 표시를 했다.

➡️ 다음:
- 직접 조립하는 키트라면 → [04_모터_ID_설정.md](./04_모터_ID_설정.md)
- **조립 완성품**을 받았다면 → [06_캘리브레이션.md](./06_캘리브레이션.md)
