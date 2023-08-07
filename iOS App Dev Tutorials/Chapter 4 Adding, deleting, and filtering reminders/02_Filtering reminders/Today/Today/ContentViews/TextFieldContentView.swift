//
//  TextFieldContentView.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

// MARK: - TextFieldContentView
/// UIContentView 프로토콜을 채택하면 이 view가 구성 내에서 정의한 콘텐츠 및 스타일을 렌더링한다는 신호를 보냄
/// 콘텐츠 보기의 구성은 view를 사용자 지정하기 위해 지원되는 모든 속성 및 동작에 대한 값을 제공
class TextFieldContentView: UIView, UIContentView {
    // MARK: - Configuration
    /// UIContentConfiguration을 준수하는 Configuration이라는 내부 구조체
    /// TextFieldContentView.Configuration 유형을 사용하여 구성 및 보기의 콘텐츠를 사용자 지정
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        
        // 기본 빈 작업으로 onChange 핸들러를 추가
        // 클로저는 사용자가 텍스트 필드에서 텍스트를 편집할 때 수행하려는 동작을 보유
        var onChange: (String) -> Void = { _ in }
        
        // MARK: - makeContentView
        /// UIContentView 프로토콜을 준수하는 UIView를 반환하는 makeContentView()
        /// 이 함수는 UIContentConfiguration 프로토콜을 준수하기 위해 포함해야 하는 최종 동작
        func makeContentView() -> UIView & UIContentView {
            // self를 사용하여 새 텍스트 필드 콘텐츠 view를 반환
            return TextFieldContentView(self)
            // TextFieldContentView의 초기화 프로그램은 UIContentConfiguration을 사용
            // 그러나 이 UIContentConfiguration에는 텍스트 필드 내에 패키지된 콘텐츠를 나타내는 문자열이 있음
        }
    }
    
    let textField = UITextField()
    // UIContentConfiguration 유형의 구성이라는 변수 추가
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    // 기본 콘텐츠 크기를 재정의하여 높이를 액세스 가능한 컨트롤의 최소 크기인 44포인트로 고정
    // 이 intrinsicContentSize을 설정하면 사용자 지정 보기가 기본 크기를 레이아웃 시스템에 전달
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    // 이니셜라이저에서 콘텐츠 구성을 수락하고 매개 변수의 값을 구성 프로퍼티에 할당
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        /// addPinnedSubview(_:insets:)를 호출하여 텍스트 필드를 고정한 다음 수평 패딩 삽입을 제공
        /// 텍스트 필드는 슈퍼뷰의 상단에 고정되며 수평 패딩은 16
        /// 상단 및 하단 인세트가 0이면 텍스트 필드가 슈퍼뷰의 전체 높이에 걸쳐 있게 함
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        // editingChanged 이벤트에 대한 대상 및 작업을 설정
        /// 이 view에 대상 및 작업을 추가하면 컨트롤이 사용자 상호 작용을 감지할 때마다 view가 대상의 didChange(_:) 선택자를 호출
        /// 이 경우 사용자가 필드의 텍스트를 변경할 때마다 메서드를 호출
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        
        /// 텍스트 필드의 clearButtonMode를 .whileEditing으로 설정
        /// clearButtonMode는 텍스트 필드에 콘텐츠가 있을 때 후행 쪽에 텍스트 지우기 버튼을 표시하도록 지시하여 사용자가 텍스트를 빠르게 제거할 수 있는 방법을 제공
        textField.clearButtonMode = .whileEditing

    }
    
    // 커스텀 이니셜라이저를 구현하는 UIView 서브클래스는 필수 init(coder:) 이니셜라이저도 구현이 필요
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    // UIContentConfiguration 매개변수를 허용하는 configure(configuration:) 함수
    func configure(configuration: UIContentConfiguration) {
        // 구성 매개 변수를 TextFieldContentView.Configuration으로 캐스팅합니다. 그렇지 않으면 함수 호출 지점으로 돌아감
        // 이 구성에 대한 입력에는 텍스트 필드의 내용으로 설정할 수 있도록 연결된 텍스트 속성이 있어야 함
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
    
    // MARK: - didChange
    // @objc 특성을 사용하여 Objective-C 코드에서 속성이나 메서드를 사용할 수 있도록 알림을 식별 가능하게 만들기에서 기억할 수 있음
    @objc private func didChange(_ sender: UITextField) {
        // guard 문을 사용하여 선택적으로 구성 속성을 상수에 바인딩
        // 속성에 값이 없거나 잘못된 유형인 경우 함수 호출 지점으로 돌아감
        guard let configuration = configuration as? TextFieldContentView.Configuration else { return }
        // onChange 핸들러를 호출하고 텍스트 필드의 내용을 전달
        configuration.onChange(textField.text ?? "")
    }
}

extension UICollectionViewListCell {
    // MARK: - textFieldConfiguration
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
    
}
