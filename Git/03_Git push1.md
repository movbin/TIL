# Git

버전을 통해 코드를 관리 하는 도구



## SCM & VCS

+ SCM (Source  Code Management) : 코드 관리
+ VCS (Version Control System) : 버전 관리 (버전 관리가 필요한 이유? )



## Git 명령어

> Git은 **폴더 단위**로 프로젝트/코드를 관리

### 1. `git init`

initialize, initiate 

+ git으로 코드 관리를 시작.
  1. `(master)` 라는 표시가 프롬프터에 생긴다. 
  2. `.git`폴더가 생성됨 → .이 붙은 숨김폴더는  `ls -a`명령으로 볼 수 있다.



### 2. `git status`

**가장 중요한 명령어** 

+ git의 상태를 출력

  1. `git init` 직후

  ```
  On branch master
  No commits yet
  nothing to commit (create/copy files and use "git add" to track)
  ```

  - No commits yet : 아직 commit이 없다. (버전==스냅샷==저장==기록==특정상태)
  - nothing to commit : commit 할 게 없다.

  2. `touch a.txt`명령으로 `a.txt`파일 추가 후

  ```
  On branch master
  
  No commits yet
  
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
          a.txt
  
  nothing added to commit but untracked files present (use "git add" to track)
  ```

  + untracked files : 추적되지 않는 파일이 있어요. (어떤 파일)
  + nothing added to commit but untracked files present (use "git add" to track) : commit할 파일은 없지만, 추적되지 않는 파일은 있다.

  3. `git add a.txt`이후

  ```
  On branch master
  
  No commits yet
  
  Changes to be committed:
    (use "git rm --cached <file>..." to unstage)
          new file:   a.txt
  ```

  - Changes to be committed : commit 될 준비가 된 파일이 있음. staging area로 옮김

  4. `git config` 이후엔 확인 방법 있으니 생략
  5. `git commit -m '[커밋 메세지]'`

  ```
  On branch master
  nothing to commit, working tree clean
  ```

  - nothing to commit, working tree clean : commit이 잘 됐고, 할 것이 없다. 

<img src="C:\Users\dlrpa\Pictures\Screenshots\SmartSelectImage_2021-01-07-17-12-45.png" alt="지금 이 상태" style="zoom: 67%;" />

### 3. `git add [파일명]`

+ git이 스냅샷을 찍기 위해 추적하는 리스트(staging area)에 파일 추가

찍을 파일, 찍지 않을 파일 선택 가능

+ 만약에 `git add`한 것을 빼고 싶다면 `git restore --staged [파일명]`
+ staging area에 올렸더라도 수정하고 싶으면 `git add`로 다시 staging area에 올려야 함



### 4. `git config` 설정

이걸 해야 commit 할 수 있음

처음에 한번만 쳐도 됨

+ `git config --global user.name` : 
+ `git config --global user.email` : Github 가입 메일
+ 위 명령어를 한번 쳐서 name, email 설정하고, 한번 더 치면 확인할 수 있음



### 5. `git commit -m '[커밋 메세지]'`

git을 통해 스냅샷을 찍음 (== 버전을 만듬, 현재 상태를 저장)

+ `-m` : message 줄임말

1. 언제 찍었는지
2. 누가 찍었는지 : 이름, 이메일
3. 메시지
4. `commit hash` : commit들을 구분시키기 위한 구분자



### 6. `git log`

git으로 지금까지 commit된 정보를 보여줌

+ `git log --oneline` : 한 줄로 커밋을 출력(author, date는 나오지 않게, id는 앞 8자만 출력)
+ `git log --[숫자]` : 입력된 숫자만큼 역순 출력(최신 커밋부터 출력)

```
$ git log
commit 5f0ea12bb2209d0f67ae80001132e9738bd27dca (HEAD -> master)
Author: hyebin <dlrpanjtdldu@naver.com>
Date:   Thu Jan 7 16:50:05 2021 +0900

    first commit

```

- commit 5f0ea12bb2209d0f67ae80001132e9738bd27dca : commit의 id = 구분자

- Author: hyebin <dlrpanjtdldu@naver.com> : `git config`에서 된 commit 한 사람
- Date:   Thu Jan 7 16:50:05 2021 +0900 : commit 한 시기
-  first commit : `git commit -m 'first commit'`명령으로 쓴 커밋 메세지



이후에 b.txt, c.txt, d.txt도 만들어서 commit하게 되면 → 하나씩 늘어간 기록을 볼 수 있다.

![](C:\Users\dlrpa\Pictures\Screenshots\SmartSelectImage_2021-01-08-09-13-29.png)





