## JSON

> JSON은 JavaScript Object Notation의 약자
> <br/>
> 시스템 간에 데이터를 전송하기 위한 간단하고 사람이 읽을 수 있으며 이식 가능한 메커니즘을 제공
> <br/>

JSON에는 문자열, 부울, 배열, 개체/사전, 숫자 및 null 중에서 선택할 수 있는 데이터 유형이 제한되어 있음
<br/>
cf. Swift 4때에는 SON을 데이터 개체로 또는 그 반대로 변환하려면 JSONSerialization 클래스를 사용해야 했음
<br/>
지금은 Codable 이용 -> 데이터 모델을 Codable에 맞추면 JSON에서 데이터 모델로 거의 자동으로 변환
<br/>
