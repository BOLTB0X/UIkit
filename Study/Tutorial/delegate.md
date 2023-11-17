# Delegate

> Delegate 패턴은 delegate, 즉 위임자를 갖고 있는 객체가 다른 객체에게 자신의 일을 위임하는 형태의 디자인 패턴이다.
> <br/>

즉 **한 개체가 다른 개체를 대신하거나 다른 개체와 함께 작동하는 메커니즘**
<br/>

> 예를 들어
> <br/>
> data 전달하거나 task를 처리하는데, 작업이 많아 원래 일을 처리해야 할 곳이 아닌 다른 컨트롤러에게 대신 수행하도록 시키는 것
> <br/>

Apple은 대부분의 UIKit 클래스에서 이 접근 방식을 사용
<br/>

ex. UITableView, UITextView, UITextField, UIWebView, UICollectionView, UIPickerView, UIGestureRecognizer, UIScrollView
<br/>

```swift
class ViewController: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self // delegate를 대리자로 설정
    }

    // 여기 UITextFieldDelegate의 메서드를 사용목적에 맞게 가져와 사용
}
```

Delegate(ex. UITextFieldDelegate)의 메서드를 사용목적에 맞게 가져와 사용
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

[블로그 참조](https://velog.io/@zooneon/Delegate-패턴이란-무엇일까)
<br/>


[UITextFieldDelegate 공식문서](https://developer.apple.com/documentation/uikit/uitextfielddelegate)
<br/>