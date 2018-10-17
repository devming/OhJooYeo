# OhJooYeo README

This repository covers the API materials for the OhJooYeo mobile service. 

Current Version: __v 0.0.1__

## TODO List (인지하고 있어야함)

__1__: 웹 관리자 페이지에서 관리자가 악보 입력할 때, 제목, 카테고리, 순서 정보도 넣어줘야함

__2__: 이미지 Request, Response 

__3__: 주보가 등록된 날짜 리스트를 불러오는 API -> Request(No Param) / Response([date + worship_id])

## Tech Stack(include libraries) ##

Xcode, Git, Swift4, CoreData, Alamofire, SwiftyJSON, 


## API ##


The API endpoint can be found at: 

__hostname__: 

__port__: 

* Return Type에 별도의 표기 없이 Example만 적었다면 모두 String 타입이다.



### <font color="blue"> POST /worship-id/{id}/check/version/{version} </font> __[Enabled]__

1. __Description__ 
   
   현재 날짜 기준 최신 주보의 버전을 가져온다.-> 예배 id에 따라 주보의 버전을 가져온다.-> 앱에 저장되어 있는 버전이 응답받은 서버의 버전과 다르면 데이터 새로고침을 위한 API를 호출하고, 같다면 API호출 없이 내부적으로 저장된 데이터를 사용한다.
   ```   
	[ex] /date/2018-04-29/worship-id/36-09/check/version/acb
	
	Description: 버전(a - z): z로 갈수록 최신 버전
	
	"acb"를 예로 들었을 경우 다음과 같다. 
	   
	a: 요청 date에서 "순서"에 대한 수정 버전(첫번째 문자)  -> 순서에 대한 첫번째 버전
	c: 요청 date에서 "광고"에 대한 수정 버전(두번째 문자)  -> 광고에 대한 세번째 업데이트 버전
	b: 요청 date에서 "악보"에 대한 수정 버전(세번째 문자)  -> 악보에 대한 두번째 업데이트 버전
	
	*: 최초 요청
   ```
   
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   - No Parameter

4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    401 | Invalid date value. 
    404 | Data doesn't exist error.

    - Response Data
    
   ```
	{
		"worship": {
		   "mainPresenter": "인도자 이름" [String],
		   "worshipOrder": [{
				"title": "순서1 - 순서 1에 해당하는 제목" [String],
				"detail": "순서1 - 순서 1에 해당하는 상세 항목" [String],
				"presenter": "순서1 - 순서 1에 해당하는 대표자" [String],
				"order": 예배 순서 [Int]
			}],
			"nextPresenter": {
				"mainPresenter":"다음주 인도자 이름",
				"prayer":"다음주 기도자 이름",
				"offer":"다음주 헌금위원 이름"
			}
		},
		"advertisement": [{
				"title": "광고 소식1" [String],
				"content":"광고 내용1" [String],
            	"order": 광고 순서 [Int]
		}],	
		"music": [{
				"id": 악보 이미지 데이터 index값 [Int],
				"title": "찬양 제목1" [String],
				"imageName": "악보 이미지 파일 이름.확장자" [String],
				"category": 카테고리 번호(자세한 종류는 아래 category enum 참고) [String],
				"order": 악보 순서 [Int],
				"lylics": 악보 가사 [String]
		}],
       "currentVersion": "현재 서버에서의 버전 정보" [String],
       "worshipDate": "예배 날짜" [String]
	}
   ```
   

	- Category Enum
	
   ```
   1: "찬양시간"
   2: "봉헌"
   3: "말씀후찬양"
   ```
   
   - Response Example
   
   ```
   {
       "worship": {
           "nextPresenter": {
               "offer": "서동주",
               "prayer": "박요한",
               "mainPresenter": "김한나"
           },
           "mainPresenter": "박요한",
           "worshipOrder": [
               {
                   "presenter": "회중",
                   "title": "경배와찬양",
                   "order": 1
               },
               {
                   "presenter": "정애림",
                   "title": "기도",
                   "order": 2
               },
               {
                   "presenter": "인도자",
                   "detail": "욘 2:7-2:10/고전 2:1-3:1",
                   "title": "성경봉독",
                   "order": 3
               },
               {
                   "presenter": "김희선전도사님",
                   "detail": "감사의 노래",
                   "title": "설교",
                   "order": 4
               },
               {
                   "presenter": "표준범",
                   "title": "헌금",
                   "order": 5
               },
               {
                   "presenter": "설교자",
                   "title": "헌금기도",
                   "order": 6
               },
               {
                   "presenter": "인도자",
                   "title": "성도의교제",
                   "order": 7
               },
               {
                   "presenter": "회중",
                   "title": "파송찬양",
                   "order": 8
               },
               {
                   "presenter": "회중",
                   "title": "주기도문",
                   "order": 9
               }
           ]
       },
       "advertisement": [
               {
                   "title": "환영",
                   "content": "돈암동교회 청년예배에 처음 방문하신 여러분을 환영합니다.",
                   "order": 1
               },
               {
                   "title": "청년예배",
                   "content": "주일 오후2시 입니다.",
                   "order": 2
               },
               {
                   "title": "기도모임",
                   "content": "주일 오후1시30분(1330기도회)",
                   "order": 3
               },
               {
                   "title": "대표기도 및 특송",
                   "content": "신청하고자 하시는 분은 임원에게 문의해주십시오",
                   "order": 4
               },
               {
                   "content": "오늘은 사순절 제3주 입니다.",
                   "order": 5
               }
           ],
           "music": [{
				"id": 5,
				"title": "주께 경배",
				"imageName": "img005.png",
				"category": 1
				"order": (integer값 - 악보 순서)
		},
		{
				"id": 12,
				"title": "주께 경배",
				"imageName": "img012.png",
				"category": 1
				"order": 1
		},
		{
				"id": 9,
				"title": "주께 경배",
				"imageName": "img009.png",
				"category": 2
				"order": 1
		}],
       "currentVersion": "bbb",  <- test용!
       "worshipDate": "2018-08-04"
   }
   ```
   
   - Response Description
   
   ```
	worship, phrase, advertisement, praise가 null이라면 최신버전인 것이다.
   ```
	


### <font color="blue"> GET /worship-list </font> __[Enabled]__

1. __Description__ 
   
   현재 주보 정보가 있는 날짜와 worship id에 대한 리스트 정보를 불러온다.
   
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   null

4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    404 | Data doesn't exist error.
    405 | Invalid URL.

    - Response Data
    
   ```json 
	[{
		"date": "주보 정보가 있는 날짜" [String],
		"worshipId": "예배 별 ID 값" [String]
	}]
   ```



### <font color="green"> POST /order </font>

1. __Description__ 
   
   주보의 가장 첫 화면 목록 리스트를 불러온다. 성공 했다면 200 코드를 반환하고, 주보 순서지에 해당하는 JSON 목록을 리턴받는다.
 
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   - Data Type
   ```json
   {
      "date": "Date"
   }
   ```
   - Data Sample
   
   ```json 
   {
      "date": "2018-05-23"
   }
   ```


4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    401 | Invalid parameter error.
    404 | Data doesn't exist error.
    
    - Response Data
    
   ```
   { 
	   "mainPresenter": "박요한",
	   "worshipOrder":
			[
				{
					"title": "순서1 - 순서 1에 해당하는 제목",
					"detail": "순서1 - 순서 1에 해당하는 상세 항목",
					"presenter": "순서1 - 순서 1에 해당하는 대표자",
					"order": (integer값 - 예배 순서)
				}, 
				{
					"title": "순서2 - 순서 2에 해당하는 제목",
					"detail": "순서2 - 순서 2에 해당하는 상세 항목",
					"presenter": "순서2 - 순서 2에 해당하는 대표자",
					"order": (integer값 - 예배 순서)
				}, 
				...
			],
		"nextPresenter": 
			{
				"mainPresenter":"김한나",
				"prayer":"박요한",
				"offer":"서동주"
			}
	}
   ```

### <font color="blue"> POST /launch/{date} </font>

1. __Description__ 
   
   Launch Screen에서 띄워줄 말씀을 가져온다. Local에 저장된 말씀 연도가 바뀌면 가져온다. `:year`에 현재 날짜 기준의 연도(yyyy)에 해당하는 int 값을 전송한다. Status code값이 200 이면, 해당 연도에 매칭되는 말씀을 리턴 받는다.
   
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   null


4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    401 | Invalid year value(yyyy). 
    404 | Data doesn't exist error.

    - Response Data
    
   ```json 
	{
		"phrase": "런치 스크린에 나오는 말씀. "
	}
   ```

   
### <font color="green"> POST /phrase </font> __[Enabled]__

1. __Description__ 
   
   주보 순서지에 해당하는 말씀 내용을 불러온다. Request Parameter에 포함된 `phrase`에 해당하는 말씀을 Response 받는다.
 
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   ```json 
   {
   		"phraseRange": "성경 a:b(-a:b)(/성경 a:b(-a:b))" [String]
   	}
   ```


4. __Response__

	- Response Code
	 
     Status Code       | Response         
    ------------|---------- 
     200 | Operation succeeded.
     400 | Unknown error. 
     401 | Invalid parameter error.
     404 | Data doesn't exist error.

    - Response Data

    ```
    [
    	{
	    	"phrase":"창 1:3",
	    	"contents":"말씀내용"
    	},
    	{
	    	"phrase":"창 1:4",
	    	"contents":"말씀내용"
    	},
    	...
    ]
    ```
 

### <font color="green"> POST /advertisement </font>

1. __Description__ 
   
   광고(교회소식) 내용을 불러온다.
 
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   - Data Type
   
   ```json    
	{
		"date": "Date"
	}	
   ```
   
   - Data Sample
   
   ```json 
	{
		"date": "2018-05-23"
	}	
	```


4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    401 | Invalid parameter error.
    404 | Data doesn't exist error.
    
    - Response Data
    
   ```
   {
   		"advertisementList": [
			{
				"title": "환영",
				"contents":"돈암동교회 청년예배에 처음 방문하신 여러분을 환영합니다."
			},
			{
				"title": "청년예배",
				"contents": "주일 오후 2시 입니다."
			},
			...
		]
	}
   ```



### <font color="green"> POST /praise </font>

1. __Description__ 
   
   해당 날짜에 맞는 찬송 악보이미지를 가져온다.
   
   > 본 API는 이미지 라이센스에 대한 문제로 인해 사용할지에 대해 추후 논의가 필요하다.
   
2. __Headers__
   
   Content-Type: multipart/form-data

3. __Body__
   
   multipart data. Consult appropriate HTTP documentation for more info. 

4. __Response__

	- Response Code
	
    Status Code       | Response         
    ------------|---------- 
    200 | Operation succeeded.
    400 | Unknown error. 
    401 | Invalid parameter error. 
    404 | Data doesn't exist error.

    - Response Data
    
   ```
	Multipart Image datas.
   ```
   

  
 
