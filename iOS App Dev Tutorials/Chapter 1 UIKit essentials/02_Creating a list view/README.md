# Xcode

## Xcode 프로젝트 구조

![](https://docs-assets.developer.apple.com/published/02d9fb638acb119ac0c701c0efab7c4c/SUI_010-005-intro~dark@2x.png)
<br/>

Source files, Configuration files, Build settings
<br/>

## Simulator

![](https://docs-assets.developer.apple.com/published/f94247b91f218982a4fff04f3186aeca/UIK010_010-030~dark@2x.png)
<br/>
시뮬레이터는 앱의 모양과 동작의 대부분의 측면을 테스트하기 위한 현실적인 환경
<br/>

## Storyboard

iOS 앱의 사용자 인터페이스를 시각적으로 표현하는 콘텐츠 화면, 그리고 화면 간의 연결을 보여주는 도구
<br/>
TODO: 이번 Tuturial에서는 코드로 UI를 구성하므로 추후 스토리보드 관련 레파지토리 추가예정
<br/>

## ViewController : 사용자 인터페이스 관리

> 1. 뷰와 데이터 모델 간의 다리 역할
>    <br/>

> 2. 각 뷰 컨트롤러는 뷰 계층 구조 관리, 뷰의 콘텐츠 업데이트, 사용자 인터페이스의 이벤트 응답을 담당
>    <br/>

> 3. Interface Builder를 사용하여 collection view controller를 생성
>    <br/>

즉, 앱의 근간을 이루는 객체로 모든 앱은 최소한 하나 이상의 뷰컨트롤러를 가짐
<br/>
viewcontroller에 해당하는 UIKit 프레임워크의 클래스는 'UIViewController'
<br/>
핵심역할은 즉 뷰(화면의 구성요소)를 관리, 거기다 view와 data사이의 상호 작용관리까지 처리
<br/>
cf. 다른 controller에 연결될 클래스는 작성하려면 반드시 UIViewController클래스를 상속해야 됌
<br/>

### ViewController 동작 방식

ViewController의 동작 방식은 아래 순서대로 진행 됌

1. 윈도우 객체로 부터 전달된 이벤트를 받음
2. 내부적으로 구현된 비즈니스 로직을 실행
3. 그 결과로 얻어진 data를 콘텐츠를 만들어 화면에 표현

모바일 App에서 viewController는 view 구성을 넘어 개발자들의 업무 대부분의 작업들의 중심
<br/>

### ViewController 종류

ViewController, Navigation Controller, TableView Controller, TabBar Controller, Split ViewController, CollectionView Controller 등등
<br/>

## Collection View controller: 일정한 가로 세로 개수를 가진 목록객체

![](https://docs-assets.developer.apple.com/published/858ca5e2e2595be9b05487d9241ab531/UIK010_020-intro~dark@2x.png)
<br/>
이번 튜토리얼에 주로사용할 View controller
<br/>
사진첩이나 갤러리에 주로 사용
<br/>

## 초기 View Controller 설정

![](https://docs-assets.developer.apple.com/published/2999d25d71b74dfdc8757316efca0179/UIK010_020-050~dark@2x.png)
<br/>
Controller를 변경하면 속성 인스펙터에서 Is Initial View Controller 체크박스를 선택하여 장면을 스토리보드 진입점으로 설정
<br/>
앱에는 여러 개의 스토리보드가 있을 수 있므로 앱 프로젝트 파일의 기본 인터페이스 설정에 따라 앱이 시작될 때 로드되는 스토리보드가 결정
<br/>

## MVC

![](https://docs-assets.developer.apple.com/published/ba3a9d5e35b72a6ac9253078a162e091/UIK010_030-intro~dark@2x.png)
<br/>

> UIKit 앱의 일반적인 디자인 패턴인 MVC(Model-View-Controller) 디자인 패턴
> <br/>

TODO: 추후 추가예정
<br/>

## Configure the collection as a list

```swift
private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    }
```

그룹화된 모양으로 새 목록 구성 변수를 만드는 listLayout()이라는 새 함수
<br/>
즉 UIkit는 특정 ViewController 클래스를 선언하고 이에 맞는 함수, 프로터피등 을 선언하면서 view와 로직을 만듬
<br/>

## viewDidLoad()

> UIViewController 의 method로 메모리에 view controller 가 올라오면 가장 먼저 실행된다. 주로 추가적인 초기화 작업을 구현하기 위해 오버라이딩 되어 사용
> <br/>

```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 여기에 추가
        let tmp = madedFunction()
    }
}
```

즉 위에서 viewcontroller를 만들고 viewDidLoad()를 오버라이딩하여 이를 추가해줘야지 viewcontroller가 실행 됌
<br/>

## cell registration

```swift
// 문서에서 발취
let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
    }
}
```

제네릭 타입 선언을 통해 해당 셀에 해당 아이템을 사전에 등록
<br/>
해당 셀 등록 인스턴스를 이니셜라이즈할 때 생성되는 핸들러에서 셀과 인덱스 패스, 아이템 등이 클로저를 통해 들어오는데 이를 통해 해당 셀의 인스턴스 메소드(즉 해당 셀을 만들 때 넣어둔 커스텀 함수와 함께) 사용 가능
<br/>

## snapshot

일단 UI의 버전(truth)를 저장하는 개념
<br/>
각 section과 item에 대한 unique identifier를 저장하고 이를 기반으로 업데이트를 수행
<br/>
TODO
<br/>

## tutorial 주소

> https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view
