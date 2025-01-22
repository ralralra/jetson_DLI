
# for jetson nano starters... 
Basically, you have to burn the SD card format and image file.

The image file is
[here](https://developer.nvidia.com/embedded/downloads#?search=nano)
1. download - jetpack 4.6.1 
2. sd card formatter
3. balena etcher
4. [how to](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write)

---
# fan operation
jtop is a system monitoring tool.

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
