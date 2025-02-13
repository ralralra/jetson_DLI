# doker 설치와 준비

1. DLI docker 설치 준비.
2. DLI docker이미지를 설치.
3. 카메라 연결과 동작까지 확인
4. 젯슨은 유선(이더넷) 또는 무선(WiFi)로 인터넷에 연결되어있어야합니다. 

# dir 추가하기
```mkdir -p ~/nvdli-data```

```#!/bin/bash```

```
#도커명령
sudo docker run --runtime nvidia -it --rm --network host \
    --memory=500M --memory-swap=4G \
    --volume ~/nvdli-data:/nvdli-nano/data \
    --volume /tmp/argus_socket:/tmp/argus_socket \
    --device /dev/video0 \
    nvcr.io/nvidia/dli/dli-nano-ai:v2.0.2-r32.7.1kr
```
![](/img/doker.png) 

**Docker가 설치되어 있는지 확인**

```docker --version```

**Docker 서비스 상태 확인**

```sudo systemctl status docker```

**Jetson에서 Docker GPU 지원 확인 (Jetson만 해당)**

```sudo docker run --runtime=nvidia --rm nvidia/cuda:11.0-base nvidia-smi```


---
# swap
Jetson 보드에서 Docker 컨테이너를 실행할 때 발생하는 메모리 문제를 해결하기 위해 swap을 사용한다

Jetson 보드는 메모리가 제한적이므로, Docker 컨테이너를 원활하게 실행하기 위해 
ZRAM을 비활성화하면 CPU 사용량을 줄이고, Docker 컨테이너가 더 많은 메모리를 사용할 수 있다

ZRAM을 비활성화하고, 스왑(Swap) 파일을 추가하는 작업을 수행하는 것

만약 Docker 컨테이너가 여러 개 실행될 경우, RAM이 부족하면 컨테이너가 충돌하거나 종료된다.

이를 방지하기 위해 스왑을 생성하여 가상 메모리를 추가하는 것

| 과정 | 이유 |
| --- | --- |
| ZRAM 비활성화 ```systemctl disable nvzramconfig```| CPU 사용량을 줄이고, 스왑을 직접 사용할 수 있도록 함 | 
| 스왑 파일 생성 ```fallocate -l 18G /mnt/18GB.swap``` | 메모리가 부족할 경우 추가적인 가상 메모리를 제공| 
| GUI 비활성화 ```systemctl set-default multi-user.target```| Docker 컨테이너 실행 시 GUI가 필요 없다면 RAM 사용량을 줄이기 위해 비활성화 |
| GUI 활성화| ```sudo systemctl set-default graphical.target```|


```multi-user.target```을 설정하면 GUI를 사용하지 않으므로 RAM 사용량이 줄어들기도 한다.


 **ZRAM 비활성화**

```
sudo systemctl disable nvzramconfig
```

 **스왑 파일 생성**
```
sudo fallocate -l 18G /mnt/18GB.swap
sudo chmod 600 /mnt/18GB.swap
sudo mkswap /mnt/18GB.swap
```

**부팅 시 자동 적용을 위해 /etc/fstab에 추가**
```
echo "/mnt/18GB.swap swap swap defaults 0 0" | sudo tee -a /etc/fstab
```

**스왑 파일 적용 (재부팅 없이 적용 가능)**

```sudo swapon /mnt/18GB.swap```

**스왑이 정상적으로 적용되었는지 확인**
```
free -h
swapon --show
```

**시스템 재부팅**
```sudo reboot```


*다시 도커 실행*
```
sudo docker run --runtime nvidia -it --rm --network host \
    --memory=500M --memory-swap=4G \
    --volume ~/nvdli-data:/nvdli-nano/data \
    --volume /tmp/argus_socket:/tmp/argus_socket \
    --device /dev/video0 \
    nvcr.io/nvidia/dli/dli-nano-ai:v2.0.2-r32.7.1kr
```


![](img/jupyter.png) 

# jupyter notebook 사용하기
*http://192.168.***.***:8888 (password dlinano)*

화면에 나온 ip주소를 브라우저로 연결한다

password는 보통 dlinano 라고 알려준다.

![](/img/008.png)   

## thumn up and thumn down
여기서 **classification** 을 선택해서 들어간다

![](/img/009.png)  

[5_classification_interactive.ipynb](5_classification_interactive.ipynb)

---

[🙋‍♂️ next thumbs up down ](https://github.com/ralralra/jetson_DLI/blob/main/5_classification_interactive.ipynb)


