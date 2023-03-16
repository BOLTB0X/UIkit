# UI structure

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbHpv9e%2FbtrtmVJw526%2FAwsG2AlVOav7OjhdSTpNkK%2Fimg.png" width="350" height="300"/>

## UIScreen

Hardware - based display 눈에 보이는 그 자체 화면 즉 물리적인 스크린
<br/>
그림과 2개 이상의 UIWindowScene을 배치할 수 있음
<br/>

## UIWindowScene

하나 또는 그 이상의 windows를 매니징 하는 scene
<br/>
UIWindowScene은 scene에서 표시하는 하나 또는 그 이상의 window를 포함하여 App UI의 하나의 인스턴스를 관리 -> 즉 Scene은 여러 Window를 포함할 수 있는 하나의 인스턴스이므로 이 Scene을 관리하는 객체라 할 수 있음
<br/>
cf.
<br/>
scene의 state 변화가 생길 경우 UIWindowSceneDelegate 프로토콜을 채택하는 delegate에게 state변화를 알린다고 하는데, 실제로 우리 Xcode상의 SceneDelegate.swift파일을 보면 이 프로토콜을 채택했음을 알 수 있음
<br/>

UIWindowScene은 여러 인스턴스가 존재할 수 있으며, iOS는 하나의 앱에 대해 여러 개의 화면을 가져서 동시에 띄울 수 있는 Multiple scenes기능을 iOS13버전 이후 부터 구현함
<br/>

## UIWindow

앱 UI의 배경이며, 이벤트들을 뷰로 보내주는 객체
<br/>

- iOS 공부를 하다보면 윈도우란 단어를 자주 보게 되는데 윈도우는 UIWindow 오브젝트를 가리키는 말이라 생각하면 됌
- Window는 이벤트를 전달해주는 매개체이자 view들을 담는 컨테이너
- 시스템 윈도우에서 생성된 이벤트들은 Key Window 로 전달
- iOS 앱은 콘텐츠를 화면에 보여주기 위해서 최소 1개 이상의 윈도우를 가짐

## UIView

화면의 사각형 영역에 대한 내용을 관리하는 Object, 대략 적으로 요약하면 뷰는 앱 사용자 인터페이스의 기본 빌딩 블록이며 UIView 클래스는 모든 뷰에 공통적인 동작을 정의
<br/>
정교한 콘텐츠를 그리기 위해 서브클래싱하기도 함
<br/>
앱에서 흔히 볼 수 있는 라벨, 이미지, 버튼 및 기타 인터페이스 요소를 표시하려면 직접 정의하려고 시도하기보다는 UIKit 프레임워크가 제공하는 뷰 하위 클래스를 사용 즉 UIKit에서 제공 ViewController도 여기 하위 클래스
<br/>

참고
<br/>
https://developer.apple.com/documentation/uikit/uiview/
<br/>
https://developer.apple.com/documentation/uikit/uiscreen/
<br/>
https://developer.apple.com/documentation/uikit/uiwindowscene/
<br/>
https://developer.apple.com/documentation/uikit/uiwindow/
