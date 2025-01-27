
# for jetson nano starters... 
기본적으로 SD 카드 형식과 이미지 파일을 구워야 합니다.

Basically, you have to burn the SD card format and image file.

이미지 파일은

The image file is
[here](https://developer.nvidia.com/embedded/downloads#?search=nano)
1. download - jetpack 4.6.1 
2. sd card formatter [Format the sd card]
3. balena etcher [Write the image]
4. [how to](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write)

---
# fan operation
jtop은 시스템 모니터링 도구입니다.

jtop is a system monitoring tool.

터미널을 열어 확인합니다

Open the terminal to check
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install python3-pip
sudo -H pip3 install -U jetson-stats
```
- Command Description
1. Prepare your system to install or update software based on the latest information
2. Update packages already installed on your system to keep them up to date
3. Install Python
Install for monitoring functionality in Jetson Nano after package management is complete
4. Check after installation: verify jetson-stats are installed properly with the jtop command
