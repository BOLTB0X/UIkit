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
}


extension UICollectionViewListCell {
    // MARK: - datePickerConfiguration
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
