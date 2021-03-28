

코드 관리 도구 & **협업 도구**

## 협업 도구로서의 git

git으로 관리되는 프로젝트 == git으로 관리되는 폴더



## Git 원격 관련 명령어

### 1. `git remote`

다른 컴퓨터에서 원격저장소에 올릴 때.

현재 관리되고 있는 원격 저장소의 정보를 출력

+ `git remote -v` : 주소까지 상세 정보를 출력 (verbose mode)

### 2. `git remote add [원격저장소의 이름] [원격저장소의 주소]`

새로운 원격저장소 정보를 추가

+ `git remote add origin https://github.com/github유저네임/저장소의이름`
+ `git remote remove` [원격저장소의 이름] []



### 3. `git push [원격저장소의 이름] [브랜치의 이름]`

원격 저장소에 코드를 업로드(밀어 넣기)

+ `git push origin master`
+ `git push -u origin master` : 업스트림(upstream)

**파일을 만들어서 →  Github에 올리는 과정은 아래와 같다.**

(중간중간 ls, ls -a, git log --oneline, git log, git status 로 확인하며 진행한다.)

<img src="C:\Users\dlrpa\Pictures\Screenshots\SmartSelectImage_2021-01-08-10-30-24.png" style="zoom:75%;" />



### 4.`git clone [원격저장소의 주소] (폴더명)`

원격 저장소의 코드를 다운로드하는 방법 중 하나

처음에만 하는 것 (`git init`과 같다.) . 같은 프로젝트 내에서 새로운 파일을 업데이트 하기 위해선 `git pull`을 쓸 것이기 때문에 `git clone`은 쓰지 않는다.

파일 전체가 다운된다. (선택적 다운 불가)

+ 또 다른 방법 : Github → my repositoies → 초록색 Code → Download ZIP



### 5.`git pull`



---

## Git으로 협업하기



### 협업의 일반 원칙

+ 하향식 & 일방적 & 독재적



### Git Branch

---

Branch == 평행 세계

### Git Branch 명령어

### `1. git branch`

+ 현재 생성되어 있는 branch들의 목력을 출력하는 명령어

### 2. `git branch [브랜치 이름]`

+ 새로운 branch 생성

### 3. `git merge [브랜치 이름]`

+ branch를 병합 (현재 속한 브랜치에서 인자로 주어진 브랜치를 합병)
  - ex) `git merge test (master)` : master 브랜치가 test를 병합 함

### 4. `git branch -d [브랜치 이름]`

> 주요 branch는 제외한 거의 모든 branch는 **일회용**이다. 병합된 branch는 항상 삭제한다.

+ `-d` : 삭제(delete)
  - ex) `git branch -d [브랜치 이름]` : test라는 branch를 삭제





## 번외 질문

### commit은 얼마나 빈번히 해야 하나요?

> 내 PJT 내 마음대로, 다른 사람들과 함께 하는 합의된 룰대로

1. 파일마다 1번씩
2. 코드 1줄마다 1번씩
3. 코드 10줄마다 1번씩
4. **내 마음대로**
5. 선임 마음대로
6. **회사 룰대로** →  logically separable functional commit (논리적으로 분리가능한 기능 중심)



### push는 얼마나 빈번히 해야 하나요?

필요할 때에 보수적으로 해야 함 → 지워지지 않기 때문

> (1) 다른 호스트/로컬 컴퓨터로 옮겨야 할 때에 (2) 코드를 공유할 때

1.  내 마음대로
2. 선임 마음대로
3. 회사 룰대로
4. 1커밋 1푸쉬
5. 10커밋 1푸쉬





