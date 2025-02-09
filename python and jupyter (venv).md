
Python을 빌드하기 위해 필요한 라이브러리 및 개발 도구를 먼저 설치

```
sudo apt update
```
```
sudo apt install -y build-essential libssl-dev libffi-dev \
    libgdbm-dev libnss3-dev libreadline-dev libsqlite3-dev \
    libbz2-dev liblzma-dev libncurses5-dev libncursesw5-dev \
    zlib1g-dev tk-dev
```

먼저 SQLite 개발 라이브러리를 설치
```
sudo apt-get install sqlite3 libsqlite3-dev
```
bz2오류방지
```
sudo apt-get install libbz2-dev
```
python3.8 설치하기
```
cd /
sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tar.xz
```

```
sudo tar -xf Python-3.8.12.tar.xz
cd Python-3.8.12
./configure --enable-loadable-sqlite-extensions
```


차례대로 실행

```
make
sudo make install
```

가상환경 만들고 실행
```
python3 -m venv myenv
source myenv/bin/activate
```

필요한 패키지들 설
```
pip install jupyter gradio pandas ipykernel
```

가상환경을 Jupyter kernel로 등록합니다

```
python -m ipykernel install --user --name=myenv --display-name="Python (myenv)"
```
