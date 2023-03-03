/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case header(String) // 연관된 문자열 값이 있는 헤더 케이스를 추가
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
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }

        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}
