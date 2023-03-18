# Alamofire

> Alamofire는 Swift 기반의 HTTP 네트워킹 라이브러리
> <br/>

일반적인 네트워킹 작업을 단순화하는 Apple의 Foundation 네트워킹 스택 위에 인터페이스를 제공
<br/>
그 기능에는 연결 가능한 요청/응답 방법, JSON 및 Codable 디코딩, 인증 등이 포함
<br/>

## 기본 네트워킹 작업을 수행

- 타사 RESTful API에서 데이터를 요청
  <br/>

- 요청 매개변수를 전송
  <br/>

- 응답을 JSON으로 변환
  <br/>

- Codable 프로토콜을 통해 응답을 Swift 데이터 모델로 변환
  <br/>

## Alamofire을 왜 쓸까

> Apple은 이미 HTTP를 통해 콘텐츠에 액세스하기 위한 URLSession 및 기타 클래스를 제공함 하지만 Alamofire은 HTTP 네트워킹 라이브러리로 Apple의 Foundation networking 기반으로 인터페이스를 제공하여 일반적인 네트워킹 작업을 단순화한다고 위에 설명함
> <br/>

Alamofire는 기존의 URL Session 기반으로 작동하며 URL Session 을 Wrapping한 라이브러리 그러므로 비즈니스 논리에 집중할 수 있고 약간의 노력으로 인터넷에서 데이터에 액세스할 수 있으며 코드가 더 가독성이 좋아짐
<br/>

- 연결가능한(Chainable) Request/Response 메서드
  <br/>

- URL / JSON / plist 파라미터 인코딩
  <br/>

- 파일 / 데이타 / 스트림 / 멀티파트 폼 데이타 업로드
  <br/>

- Request 또는 Resume 데이터를 활용한 다운로드
  <br/>

- NSURLCredential을 통한 인증(Authentication)
  <br/>

- HTTP 리스폰스 검증(Validation)
  <br/>
- TLS 인증서와 공개 키 Pinning
  <br/>

- 진행 상태 클로저와 NSProgress
  <br/>

- cURL 디버깅 출력
  <br/>

- 광범위한 단위 테스트 보장
  <br/>

- 완벽한 문서화
  <br/>

[HTTP](https://github.com/BOLTB0X/UIkit/blob/main/Study/alamofire/HTTP.md) 정리
<br/>

- GET: 웹 페이지와 같은 데이터를 가져오지만 서버의 데이터는 변경 x
  <br/>

- HEAD: GET과 동일하지만 실제 데이터가 아닌 헤더만 다시 보냄
  <br/>

- POST: 데이터를 서버로 보냄, 예를 ex) 양식을 작성하고 제출을 클릭할 때 사용
  <br/>

- PUT: 제공된 특정 위치로 데이터를 보냄, ex) 사용자 프로필을 업데이트할 때 사용
  <br/>

- DELETE: 제공된 특정 위치에서 데이터를 삭제
  <br/>

cf. [JSON](https://github.com/BOLTB0X/UIkit/blob/main/Study/alamofire/JSON.md) 정리

### REST

> REST 또는 REpresentational State Transfer는 일관된 웹 API를 설계하기 위한 일련의 규칙
> <br/>
> REST에는 요청 간에 상태를 유지하지 않고 요청을 캐시 가능하게 만들고 균일한 인터페이스를 제공하는 것과 같은 표준을 적용하는 여러 아키텍처 규칙이 있음
> <br/>

이를 통해 앱 개발자는 요청 전체에서 데이터 상태를 추적할 필요 없이 API를 앱에 쉽게 통합이 가능
<br/>
HTTP, JSON 및 REST는 개발자로서 사용할 수 있는 웹 서비스의 상당 부분을 구성
<br/>

## 주로 쓰는 함수

- AF.upload: 다중 부분, 스트림, 파일 또는 데이터 방법으로 파일을 업로드
  <br/>
  AF.download: 파일을 다운로드하거나 이미 진행 중인 다운로드를 재개
  <br/>
  AF.request: 파일 전송과 관련되지 않은 기타 HTTP 요청
  <br/>

이러한 Alamofire 메서드는 전역적이므로 이를 사용하기 위해 클래스를 인스턴스화할 필요 X
<br/>
기본 Alamofire 요소에는 SessionManager, DataRequest 및 DataResponse와 같은 클래스 및 구조체가 포함됨
<br/>

Alamofire를 사용하기 위해 전체 구조를 완전히 이해할 필요 X
<br/>

## Using a Codable Data Model

반환된 JSON 데이터를 사용하려면 JSON으로 직접 작업하는 것은 중첩 구조로 인해 복잡할 수 있으므로 이를 돕기 위해 데이터를 저장할 모델을 생성
<br>

cf. 메서드가 객체를 반환하게 되면, 메서드의 반환 값인 객체를 통해 또 다른 함수를 호출할 수 있습니다. 이러한 프로그래밍 패턴을 메서드 체이닝(Method Chaining)
<br/>

cf. ENDPOINT는 API가 서버에서 리소스에 접근할 수 있도록 가능하게 하는 URL
<br/>

## 튜토리얼 프로젝트

https://github.com/BOLTB0X/UIkit/tree/main/self-taught%20graffiti/AlamofireTutorial
