//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/27.
//

import UIKit


extension ReminderViewController {
    /// 나중에 Row의 인스턴스를 사용하여 세부 목록의 항목을 나타낼 것
    /// UIKit 목록에 데이터 및 스타일을 제공하는 비교 가능한 데이터 소스는 항목이 Hashable을 준수해야 함
    /// 왜냐하면 diffable 데이터 소스는 해시 값을 사용하여 스냅샷 간에 변경된 요소를 확인하기 때문
    enum Row: Hashable {
        case header(String) // add
        case date
        case notes
        case time
        case title
        
        
        var imageName: String? {
            switch self {
            case .date: return "calendar.circle"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }
        
        var image: UIImage? {
            /// UIImage.SymbolConfiguration에서 기호 이미지에 적용할 텍스트 두께, 글꼴, 포인트 크기 및 배율을 포함한 스타일 지정 입력을 포함할 수 있음
            /// 시스템은 이러한 세부 정보를 사용하여 사용할 이미지 변형과 이미지 스타일 지정 방법을 결정
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        // 각 사례와 관련된 텍스트 스타일을 반환하는 textStyle이라는 계산된 프로퍼티를 추가
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}
