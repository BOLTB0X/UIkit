# Delegate

> 위임자

- 위임자를 갖고 있는 객체가 다른 객체에게 자신의 일을 위임하는 형태의 디자인 패턴

- **한 개체가 다른 개체를 대신하거나 다른 개체와 함께 작동하는 메커니즘**

- **data 전달하거나 task를 처리하는데, 작업이 많아 원래 일을 처리해야 할 곳이 아닌 다른 컨트롤러에게 대신 수행하도록 시키는 것**

## 사용 이유

> Object, 이벤트 기반 프로그래밍, 콜백 처리 간의 결합도를 낮추기위해

1. **콜백 및 이벤트 처리**

- 특정 이벤트가 발생했을 때 실행할 메서드를 미리 지정 가능
- 이를 통해 이벤트가 발생했을 때, 등록된 여러 메서드를 호출하여 필요한 처리 가능
  <br/>

2. **느슨한 결합(loose coupling)**

   - 호출하는 코드와 호출되는 메서드 사이의 의존성을 낮춤
   - **delegate**가 가리키는 메서드의 구체적인 구현 내용을 알 필요 없이, 단순히 해당 **delegate**를 호출하면 되므로 유지보수가 용이
     <br/>

3. **코드의 유연성과 재사용성**

   - **delegate**를 통해 함수를 매개변수로 전달하거나, 실행 시점에 호출할 메서드를 동적으로 사용 가능
     <br/>

4. **멀티캐스팅**
   - 하나의 인스턴스에 여러 메서드를 등록할 수 있어, 하나의 이벤트에 대해 여러 처리 로직을 동시에 수행 가능
     <br/>

## UIKit

> Apple은 대부분의 UIKit 클래스에서 이 접근 방식을 사용

`UITableView`, `UITextView`, `UITextField`, `UIWebView`, `UICollectionView`, `UIPickerView`, `UIGestureRecognizer`, `UIScrollView` , .....

- 만약 `UIViewController` 에 `UITextFieldDelegate` 를 이용하려 하면?

  ```swift
  class ViewController: UIViewController, UITextFieldDelegate {
      let textField = UITextField()

      override func viewDidLoad() {
          super.viewDidLoad()

          self.textField.delegate = self // 1

      }

      // 2.

      // ....

  }
  ```

  1. `self.textField.delegate = self` : delegate를 대리자로 설정
  2. delegate 메서드
     <br/>

  ```swift

  // 지정된 텍스트 필드에서 편집을 시작할지 여부를 전달
  func textFieldShouldBeginEditing(UITextField) -> Bool {

  }

  // 지정된 텍스트 필드에서 편집이 시작될 때 전달
  func textFieldDidBeginEditing(UITextField) {

  }
  ```

## 참고

- [UITextFieldDelegate 공식문서](https://developer.apple.com/documentation/uikit/uitextfielddelegate)

- [블로그 참조 - zooneon(Delegate 패턴이란 무엇일까)](https://velog.io/@zooneon/Delegate-패턴이란-무엇일까)

- [블로그 참조 - danjychchi([UIKit] Delegate 패턴이란?)](https://velog.io/@danjychchi/UIKit-Delegate-%ED%8C%A8%ED%84%B4%EC%9D%B4%EB%9E%80)

- [블로그 참조 - tdcian([iOS / UIKit] Notification과 Delegate으로 Data를 주고받는 것에)](https://tdcian.tistory.com/357)
