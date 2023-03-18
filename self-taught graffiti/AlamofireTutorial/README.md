# Alamofire

이 튜토리얼의 앱은 Star Wars 영화와 해당 영화에 사용된 우주선에 대한 데이터에 대한 빠른 액세스를 제공하는 StarWarsOpedia 프로젝트
<br/>

cf.SW API는 스타워즈 데이터를 제공하는 무료 공개 API
<br/>

## 이 튜토리얼의 핵심 절차

1. 검색이 작동하려면 검색 기준과 일치하는 우주선 목록이 필요

2. 이를 수행하려면 우주선을 얻기 위해 엔드포인트에 검색 기준을 보내야 함
3. 이전에는 영화의 endpoint인 https://swapi.dev/api/films를 사용하여 영화 목록을 가져옴
4. https://swapi.dev/api/starships 끝점을 사용하여 모든 우주선 목록을 가져올 수도 있음
5. 엔드포인트를 살펴보면 영화의 반응과 유사한 반응을 볼 수 있음

유일한 차이점은 이번에는 결과 데이터가 모든 우주선의 목록 Alamofire의 요청은 지금까지 보낸 URL 문자열 이상을 수락할 수 있음
<br/>
키/값 쌍의 배열을 매개변수로 허용 가능
<br/>

swapi.dev API를 사용하면 starships 끝점에 매개변수를 보내 검색을 수행할수 있음 이렇게 하려면 검색 기준을 값으로 사용하여 검색 키를 사용
<br/>

## 관련 용어 설명

[Alamofire]()
[JSON]()
[HTTP]()

## 해당 Tutorial 주소

https://www.kodeco.com/6587213-alamofire-5-tutorial-for-ios-getting-started
