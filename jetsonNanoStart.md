
# for jetson nano starters... 
기본적으로 SD 카드 형식과 이미지 파일을 구워야 합니다.

*Basically, you have to burn the SD card format and image file.*

이미지 파일은

*The image file is*
[here](https://developer.nvidia.com/embedded/downloads#?search=nano)
1. download - jetpack 4.6.1 
2. sd card formatter [Format the sd card]
3. balena etcher [Write the image]
4. [how to](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write)

---
# jtop operation
jtop은 시스템 모니터링 도구이다

*jtop is a system monitoring tool.*

터미널을 열어 확인합니다

*Open the terminal to check*
```
sudo apt-get update
sudo apt-get upgrade
```
*1. Prepare your system to install or update software based on the latest information*

*2. Update packages already installed on your system to keep them up to date*

1. 최신 정보를 기반으로 소프트웨어를 설치하거나 업데이트할 수 있도록 시스템 준비하기
2. 시스템에 이미 설치된 패키지를 업데이트하여 최신 상태로 유지하기

```
sudo apt install python3-pip
```
*3. Install Python*


```
sudo -H pip3 install -U jetson-stats
reboot
```

*4. Check after installation: verify jetson-stats are installed properly with the jtop command*

4.리부팅 후 jtop 명령으로 올바르게 설치되었는지 확인

![jtop](/img/003.png)   

---
# Install and run cooling fan 

After running jtop
Check the temperature.
The temperature is very high.
Install and run the cooling fan

**Run Terminal**
```
sudo sh -c 'echo 128 > /sys/devices/pwm-fan/target_pwm'
```
To operate the fan at full speed, enter the number 256 .
There's noise, so let's run the fan on the middle power

---
# Installing the Camera

```
git clone https://github.com/jetsonhacks/USB-Camera.git
```
After 'git clone', run 'ls' to check the folder.

A 'USB-Camera' directory has been created, and it goes into 'USB-Camera'

![jtop](/img/006.png)   

If you check the list of 'USB-Camera', there is a py-in python file. 

You can run it with python3 commands
```
python3 usb-camera-gst.py
```
