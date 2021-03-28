# CLI

Command Line Interface (명령줄 인터페이스)



## GUI vs. CLI

+ GUI (Graphic User Interface): 일반적으로(일반인이) 컴퓨터를 다룬 방식(graphic 중심)

  - 마우스 중심

+ CLI: 개발자들이 다루는 방식

  - 명령어 중심

    

## 기초 명령어

폴더 == 디렉토리

쓰다가 [tab] 누르면 자동완성

+ `ls` (list): 해당 폴더(디렉토리) 내용을 출력

+ `pwd`(print working directory): 현재 위치 출력

+ `cd [폴더명]`(change directory): 폴더를 변경. [폴더명]으로 들어간다. 

들어가면 내용물 모르니까 ls 쳐서 내용물 보기

- 폴더 이동하려면
  - `cd ..`: 상위 폴더  → ex) downloads 폴더로 들어간 후 `cd ..`라고 치면 상위폴더(홈)으로 나감
  - `cd .`: 현재 폴더
  - `cd /`: 루트 폴더
  - `cd ~`: 홈 폴더

+ `touch [파일명]`: 새 파일 만들기

- `mkdir [폴더명]`(make directory) : 새 폴더 만들기
- `rm [파일명]`(remove) : 파일 삭제
- `rm -r[폴더명]`(remove recursively) : 폴더 삭제
- `cp [파일명] [위치]`(copy) : 파일 복사
- `cp -r[폴더명] [위치]` : 폴더 복사
- `mv [파일/폴더명] [바꿀 파일/폴더명]`(move) : 파일 또는 폴더를 **이동**
  - `mv`(move) : 파일 / 폴더명 변경

- `exit` : 끝내기

| **명령어(맥 OS/리눅스)** | **설명**                           | **예시**                   |
| ------------------------ | ---------------------------------- | -------------------------- |
| exit                     | 창을 닫는다                        | **exit**                   |
| cd                       | 디렉터리를 변경한다                | **cd test**                |
| ls                       | 디렉터리 혹은 파일 목록을 보여준다 | **dir**                    |
| cp                       | 파일을 복사한다                    | **copy c:\test\test.txt ** |
| mv                       | 파일을 이동한다                    | **move c:\test\test.txt ** |
| mkdir                    | 새 디렉터리를 만든다               | **mkdir testdirectory**    |
| rm                       | 디렉터리 혹은 파일을 지운다        | **del c:\test\test.txt**   |







