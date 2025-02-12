# venv
venv는 **Python의 가상 환경 Virtual Environment**을 생성하는 도구이다.

Python 프로젝트마다 독립적인 패키지 환경을 유지할 수 있도록 해 줍니다

Python을 빌드하기 위해 필요한 라이브러리 및 개발 도구를 먼저 설치

python 3.3 이상부터 기본 내장되어 있어 별도 설치 과정은 없어도 된다.

---

# python3 설치

```sudo apt upgrade```

**python3.8 소스코드 받기**
```
cd /
sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tar.xz
```
**압축 풀기**
```
sudo tar -xf Python-3.8.12.tar.xz
cd Python-3.8.12
```
![](img/python3.png)

```
#./configure --enable-optimizations
./configure --enable-loadable-sqlite-extensions --with-bz2
```
```
sudo apt-get install libbz2-dev
sudo apt-get install sqlite3 libsqlite3-dev
pip3 install --upgrade pip 
python3.8 -m pip install Jetson.GPIO 
```
![](img/bz2checking.png)


```
sudo apt install -y build-essential libssl-dev libffi-dev \
    libgdbm-dev libnss3-dev libreadline-dev libsqlite3-dev \
    libbz2-dev liblzma-dev libncurses5-dev libncursesw5-dev \
    zlib1g-dev tk-dev
```

```
make -j4
sudo make altinstall
```

---

# 가상환경 생성

```python3 -m venv myenv```


**가상환경 활성화**

```source myenv/bin/activate```


**활성화되면 프롬프트 앞에 (myenv)가 표시됨**

예)
```(myenv) user@computer:~$```


**가상환경 삭제**
예시)
```rm -rf venv #가상환경 이름 ```

---
**가상환경 만들고 실행**

![](img/myenv.png)

```
python3 -m venv myenv
source myenv/bin/activate
```

**필요한 패키지들 설치**
```
python -m pip install --upgrade pip
pip install jupyter gradio pandas ipykernel
pip install openai
pip install gradio

```
**jetson GPIO**

```pip3 install Jetson.GPIO```


가상환경을 Jupyter kernel로 등록합니다

```
python -m ipykernel install --user --name=myenv --display-name="Python (myenv)"
```
