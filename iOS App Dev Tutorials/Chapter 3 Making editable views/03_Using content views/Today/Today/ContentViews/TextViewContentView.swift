//
//  TextViewContentView.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

class TextViewContentView: UIView, UIContentView {
    // 텍스트 view 및 구성 프로퍼티, 구성 프로퍼티를 설정하는 초기화 및 텍스트 view의 텍스트 프로퍼티을 설정하는 configure(configuration:) 함수를 추가
    // MARK: - Configuration
    struct Configuration: UIContentConfiguration {
        var text: String? = ""

        // MARK: - makeContentView
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
    }


    let textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }


    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        // 이니셜라이저에서 높이가 200인 고정된 하위 보기로 텍스트 보기를 추가
        addPinnedSubview(textView, height: 200)
        
        
        // 텍스트 보기는 스크롤 view
        // 텍스트 뷰에 고정된 높이를 할당하더라도 스크롤 뷰는 사용자가 들어갈 수 있는 것보다 더 많은 텍스트를 입력하는 경우 자동 스크롤 및 스크롤 표시기로 사용자를 수용
        // 이니셜라이저에서 텍스트 뷰의 선택적 배경색을 nil로 설정
        textView.backgroundColor = nil
        
        // 사용자는 편집 가능한 메모 텍스트 보기에서 실질적인 텍스트를 입력할 수 있음
        // 텍스트 본문을 위한 글꼴 스타일은 적절한 디자인 선택
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textView.text = configuration.text
    }
}


extension UICollectionViewListCell {
    // MARK: - textViewConfiguration
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
