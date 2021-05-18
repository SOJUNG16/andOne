# &amp;분의일

함께하는 지역공동체 서비스를 컨셉으로 N분의 1로 나누고, AND, 함께한다는 중의적 의미를 담고 있습니다.
이웃과 물건을 함께 사고 나누는 것뿐만 아니라,  위치 기반 소모임 서비스를 제공하고
지역 업체들의 정보와 리뷰 서비스도 제공하여 진정한 의미의 함께하는 지역공동체 서비스를 지향하고 있습니다

* <b>개발 기간</b> : 2020.08.21 ~ 2020.11.13
* <b>개발 인원</b>:  5명(팀 프로젝트)

![image](https://user-images.githubusercontent.com/66711644/118234964-092b6180-b4cf-11eb-93c6-c300af4633bc.png)
 ![엔분의일](https://user-images.githubusercontent.com/66711644/118235276-8060f580-b4cf-11eb-877d-fda527a5bd83.png)
<details>
    <summary>추가 이미지</summary>
    <div markdown="1">

 ![다국어처리](https://user-images.githubusercontent.com/66711644/118235160-57d8fb80-b4cf-11eb-8719-3e6e3dd83cdd.png)
 ![소모임](https://user-images.githubusercontent.com/66711644/118235374-a2f30e80-b4cf-11eb-8dc7-4050286270b0.png)
 ![업체정보](https://user-images.githubusercontent.com/66711644/118235543-e0579c00-b4cf-11eb-8987-6987f3ff72c3.png)
 ![마이페이지](https://user-images.githubusercontent.com/66711644/118235688-1137d100-b4d0-11eb-88d8-e75d68fbf426.png)

    </div>
</details>

<br>

## 1. 사용기술

* Java 8 
* Spring 4.3
* Javascript 
* Oracle DB 
* AWS EC2/RDS

<img src="https://stothey0804.github.io/assets/images/project/stack.png">

<br>

## 2. ERD 설계

![모델링(물리)](https://user-images.githubusercontent.com/66711644/112282000-03cd4a00-8cca-11eb-8b54-6c677ffb05aa.PNG)

<br>

## 3. 구현 기능

이 서비스는 사용자의 위치기반으로 주변의 공동구매자를 찾는 것을 도와줍니다.
사용자는 등록이나 검색을 통해  공동구매 신청이 가능하며 선 결제한 포인트로 결제할 수 있습니다.

<details>
    <summary><b>구현기능 설명 펼치기</b></summary>
    <div markdown="1">
         
### 3-1. 전체흐름
![프로세스](https://user-images.githubusercontent.com/66711644/112427276-aa722300-8d7c-11eb-8db0-91b215979ee8.png)
       

 ###  3-2. spring scheduler

* 일정주기마다 상태를 확인하여 변경/지급을 진행합니다. :pushpin: [코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/java/project/and/p001/controller/AndP001_d001ControllerImpl.java#L300)

### 3-3. 게시판 CRUD

* 게시판 글쓰기/수정/삭제 를 구현했습니다. :pushpin: [코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/java/project/and/p002/controller/AndP002_d001ControllerImpl.java#L34) 
* 상세조회를 구현했습니다. :pushpin: [코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/java/project/and/p001/controller/AndP001_d001ControllerImpl.java#L231)

### 3-4. 포인트 충전

* 간편 결제(카카오페이) API를 이용해 포인트를 충전 후 결제를 진행합니다. :pushpin: [코드 확인](https://github.com/stothey0804/andOne/blob/abf1db045fd26d6c2502e5fea8e3ccb1ea915d67/src/main/java/project/point/p001/controller/PointP001_d003ControllerImpl.java#L33)

### 3-5. 회원가입/로그인

* Ajax를 이용해 중복체크(회원가입)와 ID와 PW(로그인)를 확인합니다. :pushpin: [코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/java/project/shop/p001/controller/ShopP001_d001ControllerImpl.java#L35) [코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/java/project/shop/p001/controller/ShopP001_d002ControllerImpl.java#L36)


</div></details>

<br>

## 4. 트러블슈팅경험

<details>
    <summary>AWS RDS 속도 저하 문제</summary>
    <div markdown="1">

* 기존 리전(Regions)에 있던 RDS 데이터베이스 스냅샷을 복사해 리전을 서울로 변경함. 

    </div>
</details>

<details>
    <summary>게시판 정렬과 페이징 처리</summary>
    <div markdown="1">

* 메인과 검색결과에서 게시물을 최신순/마감순 정렬로 볼 수 있게 구성했습니다. 
이 때 정렬 방법에 따른 페이징을 고민하게 되었습니다. 처음에는 정렬방법에 따라 쿼리를 따로 구성했으나 같은코드를 계속반복하는 느낌을 받았고 
* 같은 코드에 구분할 수 있는 'flag'만 추가해 하나의 코드로 두가지의 정렬을 처리할 수 있었습니다. :pushpin:[코드 확인](https://github.com/SOJUNG16/andOne/blob/9d489960897f0bb570b439e1a5967a51c88f5776/src/main/resources/mybatis/mappers/and/p001.xml#L35) 

    </div>
</details>

<details>
    <summary>거리계산 문제</summary>
    <div markdown="1">

* 위치기반 서비스로 사용자가 메인에서 선택한 위치와 게시글에 등록되어있는 위치를 비교한 정보들을 사용자에게 뿌려줘야 했습니다. 카카오맵 API를 사용해 거리계산을 하기 위해 모든 게시글을 위치정보를 JSON 형태로 화면 단에 가져와서 javascript로 계산하려고 했으나 모든 위치 정보를 다 가지고 오는 것은 효율적이지도 못하고 속도 저하를 유발한다는 생각에 고민하다가 
* 한 컬럼으로 받았던 좌표(위도/경도)정보를 위도컬럼, 경도컬럼으로 나눠서 받은 후 두 좌표 사이의 거리를 반환하는 함수를 사용해 DB에서 기준에 맞는 정보만 불러오도록 변경했습니다.
    </div>
</details>

<br>

## 5. 회고/느낀 점
 몇 달 동안 배우면서 여기저기 흩어져있던 지식이 프로젝트를 기준으로 모여서 하나의 길을 만들어 주었습니다. 프로젝트를 마친 지금 이제야 뭔가 흐름이 보인다는 느낌을 받았습니다. 배우면서 '이걸 어디서 어떻게 사용해야 하지?'라는 물음표만 가득했는데, 점차 깨닫는 느낌표가 많아졌고 그만큼 제가 많이 부족하다고 생각하게 되었습니다. 
책이나 강사님께 배운 것을 실습하는 것과 프로젝트를 진행하는 것은 정말 너무 달랐습니다. 기능을 구현해 나가면서 단 한 번이라도 문제없이 끝낸 적이 없을 정도였습니다. 그 문제를 해결하기 위해 아침부터 저녁까지 컴퓨터 앞에서 앉아서 고민하고 컴퓨터를 덮고서도 계속 생각하고 고민하다가 결국 마침내 해결했을 때의 기분을 정말 어떤 것과 비교할 수 없었습니다. 그러면서 개발에 재미를 느끼고 프로젝트를 끝까지 끝낼 수 있는 원동력을 얻었습니다.
그리고 2달 동안 프로젝트를 하면서 커뮤니케이션의 중요성을 깨달았습니다. 이 프로젝트 하나를 완성하는데 정말 많은 회의와 대화를 했습니다. 어려운 부분에 부딪혔을 때 같이 고민해주고  질문도 하면서 팀원들에게 여러 가지를 배웠고 도움받았습니다. 대화하면서 내가 잘못 이해하고 있던 부분이나 내가 알고 있는 것들을 알려주면서 나도 프로젝트에 대해 더 잘 알게 되었다. 부족한 부분이 많은 내 질문에 항상 답변해준 팀원들 덕분에 프로젝트를 잘 마무리할 수 있었습니다.  


