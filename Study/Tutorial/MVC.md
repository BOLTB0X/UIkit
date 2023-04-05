# MVC(Model-View-Controller)

<img src = "https://koenig-media.raywenderlich.com/uploads/2013/07/mvc0.png">
<br/>

iOS의 디자인 패턴 중 정말 상징적인 패턴임
<br/>

하나의 App 프로젝트를 구성할 때 그 구성요소를 세가지의 역할로 구분한 패턴
<br/>

## 각각의 역할

<img src = "https://miro.medium.com/v2/resize:fit:640/format:webp/1*CosiXBMzkt-ygAQlP-f7wA.png">

1. Model(모델): App data를 보유하고 이를 define하는 방법을 정의하는 Object
   ex) 학사정보 App에서 Model은 Student 구조체, 대부분의 App는 Model의 일부로 2개 이상를 갖음
   <br/>

즉 App에서 모델은 이런 기능으로 사용
<br/>

- data로 사용할 용도
- 네트워크 로직
- Persistance 로직
- 파싱 로직
- Manager 객체(ex. 싱글톤)
- Extension, Util,

---

2. View(보기): User가 상호 작용할 수 있는 Model 및 컨트롤의 시각적 표현을 담당하는 Obejct

그냥 실제 user에게 보여주는 화면
<br/>
기본적으로 모든 UIView 파생 Object(UIKit에서 상속 받음)
<br/>

개발과정에서 매번 코드로 새로운 view를 만들기 보단 **_view의 재사용_**을 지향
<br/>

---

3. Controller(컨트롤러): 컨트롤러는 모든 작업을 조정하는 mediator(중재자)
   Model의 data에 액세스하여 view와 함께 표시하고 이벤트를 수신하며 필요에 따라 데이터를 조작
   <br/>

흔히 Xcode로 UIKit로 프로젝트를 생성하면 자동적으로 달려있는 것이 ViewController
<br/>

Model에서 dat를 View에게 전달, View는 refresh
<br/>
View에서 받는 Event으로 새 data를 받으면 Model이 업데이트
<br/>

---

위 그림과 다르게 iOS에서는 view Object와 model 간의 직접적인 상호 작용을 피하는 것이 좋음
<br/>

3번 설명에서 처럼 View Object는 모델 개체의 변경은 항상 컨트롤러 개체를 거침
<br/>

## 실제 MVC 패턴

<img src = "hhttps://miro.medium.com/v2/resize:fit:640/format:webp/1*lhvPZM-rfy4rN09Tw2tzJA.png">
<br/>

이러다보니 UIkit에 ViewController가 무거워짐
<br/>

좋은 MVC 패턴으로 사용하려면

- 재사용 가능한 Object를 최대한 많이 사용하는 것
  <br/>

- View Object와 Model Object는 재사용 가능성이 높아야 함
  <br/>

- App별 동작은 가능한 한 Controller Object에 집중되는 경우가 많지만 View가 Model을 직접 관찰하여 상태 변화를 감지하도록 할 수 있지만 그렇게 하지 않는 것이 지향
  <br/>

- View Object는 Model Object의 변경 사항을 전달하기 위해 항상 매개 Controller Object를 거치도록 설계
  <br/>

- App Class의 코드를 종속성을 제한하도록 노력, Class가 다른 Class에 대한 종속성이 클수록 재사용 가능성이 떨어짐
  <br/>

---

TODO: Cocoa MVC

## 참고

https://developer.apple.com/documentation/uikit/about_app_development_with_uikit
<br/>
https://medium.com/@matthewan/traditional-mvc-and-mvc-in-ios-development-2280d353b459
<br/>
https://usa4060.tistory.com/6
<br/>
