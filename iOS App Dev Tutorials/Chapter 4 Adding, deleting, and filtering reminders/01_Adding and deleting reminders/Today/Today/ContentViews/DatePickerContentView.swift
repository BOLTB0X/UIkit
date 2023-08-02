//
//  DatePickerContentView.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

// UIContentView를 준수하는 DatePickerContentView라는 UIView의 하위 클래스를 추가
// 날짜 선택기는 UIKit이 사용자가 날짜 및 시간 값을 입력할 수 있도록 제공하는 컨트롤
class DatePickerContentView: UIView, UIContentView {
    // MARK: - Configuration
    struct Configuration: UIContentConfiguration {
        var date = Date.now
        var onChange: (Date) -> Void = { _ in }

        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }
    }


    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }


    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        // 이니셜라이저에서 .valueChanged 이벤트에 대한 대상 및 작업을 설정
        // view에 대상과 작업을 추가하면 보기는 날짜가 변경될 때마다 대상의 didPick(_:) 선택자를 호출
        datePicker.addTarget(self, action: #selector(didPick(_:)), for: .valueChanged)
        
        datePicker.preferredDatePickerStyle = .inline
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date
    }
    
    // MARK: - didPick
    // 이 기능은 미리 알림 날짜에 대한 편집 내용을 저장
    @objc private func didPick(_ sender: UIDatePicker) {
        guard let configuration = configuration as? DatePickerContentView.Configuration else { return }
        configuration.onChange(sender.date)
    }
}


extension UICollectionViewListCell {
    // MARK: - datePickerConfiguration
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
