# Cocoa & Cocoa Touch

> Cocoa는 OS X 운영 체제와 iOS, iPhone, iPad 및 iPod touch와 같은 Multi-Touch 장치에서 사용되는 운영 체제 모두를 위한 애플리케이션 환경

- 객체 지향 소프트웨어 라이브러리, 런타임 시스템 및 통합 개발 환경으로 구성

## Cocoa Environment

> iOS 환경에서의 Cocoa는 객체 지향 소프트웨어 라이브러리, 런타임 시스템 및 통합 개발 환경으로 구성된 엄청 큰 프레임워크

### Cocoa

<p align="center">
   <img src = "https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/art/osx_architecture-cocoa_2x.png">
   이미지 출처: developer apple(CocoaApplicationLayer)
</p>

> Cocoa는 OS X 및 iOS에서 실행되는 애플리케이션을 위한 런타임 환경을 제공하는 객체 지향 프레임워크 집합(set)

- Objective-C 런타임을 기반으로 하고, 클래스들의 가장 윗단인 루트 클래스에서 상속되는 모든 클래스 또는 객체를 지칭하는데 사용
- iOS의 유일한 애플리케이션 환경

### Cocoa Touch

> iPhone, iPad 및 iPod Touch용 API

- 그래픽 UI를 구현하는 이벤트-구동(event-driven) 기법을 쓰는 iOS용 응용 SW는 보통 코코아 터치 계층에 기반하여 작성됨

- 또한, 사용자 전화번호부(user contacts)와 같은 기기의 핵심 기능을 접근하기 위해서는 `Cocoa Touch Layer`를 이용하여야 함

- Cocoa Touch는 iOS의 소프트웨어 계층 중 가장 상위 계층

## iOS frameworks 계층 구조

> iOS의 애플리케이션 프레임워크 계층을 Cocoa Touch 라고도 함

<p align="center">
   <img src = "https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Art/architecture_stack.jpg">
   이미지 출처: developer apple(Cocoa in the architecture)
</p>

Cocoa Touch가 의존하는 iOS 인프라는 OS X의 Cocoa와 유사

1. **UIKit**: iOS의 UI를 담당
   <br/>

2. **Foundation**: 프로그램의 중심을 담당

   - Application의 모든 object를 관리하는 기본적인 틀 제공
   - 메모리 할당 혹은 반환하는 기본적인 규칙 정의
   - 딕셔너리와 같은 클래스들은 모두 ‘NS’로 시작
   - cf. Foundation이 이용하는 CoreFoundation는 하위 framwork
     <br/>

3. **CoreFoundation**: GUI와 관련된 Foundation

   - ex. 원시 바이트, 유니코드 문자열, 숫자, 달력 날짜, 배열, 사전 , 딕셔너리
   - OS 수준에서 프로세스간 통신 및 GUI 메시지 대화상자를 통해 표준화 된 응용 프로그램 기본 설정 관리를 제공
     <br/>

4. **CoreData**: 응용프로그램에서 모델 계층 개체를 관리 Framework

   - 지속성을 포함하여 객체 수명주기 및 객체 그래프 관리와 관련된 일반작업
     <br/>

5. **MapKit**: 표시 정보를 결정할 수 있는 도구모음

   - App의 인터페이스에 직접 지도 또는 위성이미지를 표시하고, 관심있는 장소를 호출
     <br/>

6. **Core Animation**: App의 시각적 요소에 애니메이션을 적용
   - iOS 및 OS X에서 사용할 수 있는 그래픽 렌더링(Graphic Rendering) 및 애니메이션 인프라
   - 사용 시 애니메이션의 각 프레임을 그리는 데 필요한 대부분의 작업을 자동 수행
     <br/>

## 참고

- [공식문서 - Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html)

- [공식문서 - Cocoa Touch](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Cocoa.html)

- [블로그 참조 -corykim0829(iOS Cocoa, Cocoa Touch
  Apple의 Cocoa 그리고 Cocoa Touch에 대해서 알아보자.)](https://corykim0829.github.io/ios/Cocoa-CocoaTouch/)

- [블로그 참조 -zieunv(cocoa touch framework)](https://corykim0829.github.io/ios/Cocoa-CocoaTouch/)

- [공식문서 - Uikit](https://developer.apple.com/documentation/uikit/about_app_development_with_uikit)
  <br/>
