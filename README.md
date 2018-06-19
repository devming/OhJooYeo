# OhJooYeo REST API server

This repository covers the API materials for the OhJooYeo mobile service. 

Current Version: __v 0.0.1__

## Architecture Overview ##

__Server__: 

__Database__: 

__Framework__: 


## API ##


The API endpoint can be found at: 

__hostname__: 

__port__: 

* Return Type에 별도의 표기 없이 Example만 적었다면 모두 String 타입이다.



### <font color="blue"> POST /version/:date </font>

1. __Description__ 
   
   현재 날짜 기준 최신 주보의 버전을 가져온다. 앱에 저장되어 있는 버전이 응답받은 서버의 버전과 다르면 데이터 새로고침을 위한 API를 호출하고, 같다면 API호출 없이 내부적으로 저장된 데이터를 사용한다.
   
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
    - Request Data
    
   ```
    1. 첫 번째 샘플
	{
		"version": "acb"
		"date": "2018-06-19"
	}
	
	2. 두 번째 샘플
	{
		"version": "d*a"
		"date": "2018-06-19"
	}
	
	3. 세 번째 샘플
	{
		"version": "***"
		"date": "2018-06-19"
	}
   ```
   
   - Request Description
   
	```   
	Description: 버전(a - z): z로 갈수록 최신 버전
	
	위의 "acb"를 예로 들었을 경우 다음과 같다. 
	   
	a: 요청 date에서 "순서"에 대한 수정 버전(첫번째 문자)  -> 순서에 대한 첫번째 버전
	c: 요청 date에서 "광고"에 대한 수정 버전(두번째 문자)  -> 광고에 대한 세번째 업데이트 버전
	b: 요청 date에서 "악보"에 대한 수정 버전(세번째 문자)  -> 악보에 대한 두번째 업데이트 버전
	
	*: 최초 요청
   ```



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
		},
		"phrase": [
		    	{
			    	"phrase":"창 1:3",
			    	"contents":"말씀내용"
		    	},
		    	{
			    	"phrase":"창 1:4",
			    	"contents":"말씀내용"
		    	},
		    	...
	   ],
		"advertisement": [
				{
					"title": "환영",
					"contents":"돈암동교회 청년예배에 처음 방문하신 여러분을 환영합니다."
				},
				{
					"title": "청년예배",
					"contents": "주일 오후 2시 입니다."
				},
				...
		],	
		"praise": {
			
		}
	}
   ```
   
   - Response Description
   
   ```
	worship, phrase, advertisement, praise가 null이라면 최신버전인 것이다.
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


### <font color="blue"> POST /launch/:date </font>

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

   
### <font color="green"> POST /detail/phrase </font>

1. __Description__ 
   
   주보 순서지에 해당하는 말씀 내용을 불러온다. Request Parameter에 포함된 `phrase`에 해당하는 말씀을 Response 받는다.
 
2. __Headers__
   
   Content-Type: application/json

3. __Body__
   
   ```json 
   {
   		"date": "2018-06-07"
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
    	"phraseList": [
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
	 }
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
   

  
 
