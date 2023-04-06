# Cocoa & Cocoa Touch

> Cocoa는 OS X 운영 체제와 iOS, iPhone, iPad 및 iPod touch와 같은 Multi-Touch 장치에서 사용되는 운영 체제 모두를 위한 애플리케이션 환경 
> <br/>
> 객체 지향 소프트웨어 라이브러리, 런타임 시스템 및 통합 개발 환경으로 구성
> <br/>

## Cocoa Environment

### Cocoa
> Cocoa는 OS X 및 iOS에서 실행되는 애플리케이션을 위한 런타임 환경을 제공하는 객체 지향 프레임워크 집합(set)
> <br/>
> Objective-C 런타임을 기반으로 하고, 클래스들의 가장 윗단인 루트 클래스에서 상속되는 모든 클래스 또는 객체를 지칭하는데 사용
> <br/>
> iOS의 유일한 애플리케이션 환경
> <br/>

### Cocoa Touch

> iPhone, iPad 및 iPod Touch용 API
> <br/>
> Cocoa Touch 계층이라고도 함 그래픽 UI를 구현하는, 이벤트-구동(event-driven) 기법을 쓰는 iOS용 응용 소프트웨어는 보통 코코아 터치 계층에 기반하여 작성됨 또한, 사용자 전화번호부(user contacts)와 같은 기기의 핵심 기능을 접근하기 위해서는 Cocoa Touch Layer를 이용하여야 함
> <br/>
> Cocoa Touch는 iOS의 소프트웨어 계층 중 가장 상위 계층
> <br/>

---

<img src = "https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Art/osx_architecture.jpg">

<br/>

<img src = "https://miro.medium.com/v2/resize:fit:640/format:webp/1*G5C1oySYKx-KUiiFgmLogg.png">

iOS환경에서의 Cocoa는 객체 지향 소프트웨어 라이브러리, 런타임 시스템 및 통합 개발 환경으로 구성된 엄청 큰 프레임워크
<br/>

'Cocoa’ 또는 ‘Cocoa Touch’라는 용어는 각 플랫폼의 프로그래밍 인터페이스를 사용하여 응용 프로그램 개발을 언급 할 때에도 사용함
<br/>

## iOS frameworks 계층 구조

<img src = "https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Art/architecture_stack.jpg">

<br/>

iOS의 애플리케이션 프레임워크 계층을 Cocoa Touch라고도 함
<br/>

Cocoa Touch가 의존하는 iOS 인프라는 OS X의 Cocoa와 유사
<br/>

1. UIKit: iOS의 UI를 담당
Xcode에서 파일추가로 새 ViewController를 생성하면 상단에 ‘import UIKit’이 기본적으로 명시되어 있는 것을 볼 수 있음
<br/>

***ViewController <- UIViewController***
<br/>

> ViewController는 UIViewController에게 상속받음
> <br/> 
> UIViewController는 UIKit에 정의된 클래스이고, 사용자의 Interface와 Action을 관리
> <br/>
> import UIKit을 해줌으로써 컴파일러가 UIViewController 클래스를 찾아 빌드를 해주는 것
> <br/>
> cf. Mac OS X에서는 ‘NS’로 시작하는 클래스의 이름을 사용
> <br/>
> UIApplication Object는 앱의 기본 이벤트 루프를 실행하고 앱의 전체 수명 주기를 관리
> <br/>

***UIKit 공식문서를 보면 core app object들이 MVC 패턴으로 되어있는 것을 확인할 수 있음***
<br/>

---

2. Foundation

#### Foundation: 프로그램의 중심을 담당
> Application의 모든 object를 관리하는 기본적인 틀 제공
> <br/>
> 메모리 할당 혹은 반환하는 기본적인 규칙 정의
> <br/>
> 리스트나 딕셔너리와 같은 클래스들은 모두 ‘NS’로 시작
> <br/>
> cf. Foundation이 이용하는 CoreFoundation는 하위 framwork
> <br/>

#### CoreFoundation: GUI와 관련된 Foundation(ex. 원시 바이트, 유니코드 문자열, 숫자, 달력 날짜, 배열, 사전 , 딕셔너리)
> 운영체제 수준에서 프로세스간 통신 및 GUI 메시지 대화상자를 통해 표준화 된 응용 프로그램 기본 설정 관리를 제공
> <br/>

---

3. CoreData: 응용프로그램에서 모델 계층 개체를 관리하는 데 사용하는 Framework

> 지속성을 포함하여 객체 수명주기 및 객체 그래프 관리와 관련된 일반작업에 일반화되고 자동화 된 솔루션 제공
> <br/>

---

4. MapKit : 앱의 인터페이스에 직접 지도 또는 위성이미지를 표시하고, 관심있는 장소를 호출하며 지도좌표에 대한 장소 표시 정보를 결정할 수 있는 도구모음
<br/>

---

5. Core Animation : iOS 및 OS X에서 사용할 수 있는 그래픽 렌더링(Graphic Rendering : 컴퓨터 프로그램을 사용하여 그래픽으로부터 영상을 만들어내는 과정) 및 애니메이션 인프라(infrastructure : 기초적인 시설 및 자원) 로서 앱의 보기 및 시각적 요소에 애니메이션을 적용하는데 사용

> 사용 시 애니메이션의 각 프레임을 그리는 데 필요한 대부분의 작업을 자동 수행
> <br/>

## 참고
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html
<br/>
https://corykim0829.github.io/ios/Cocoa-CocoaTouch/#
<br/>
https://medium.com/@zieunv/cocoa-touch-framework-bf78307c4a51
<br/>
https://developer.apple.com/documentation/uikit/about_app_development_with_uikit
<br/>