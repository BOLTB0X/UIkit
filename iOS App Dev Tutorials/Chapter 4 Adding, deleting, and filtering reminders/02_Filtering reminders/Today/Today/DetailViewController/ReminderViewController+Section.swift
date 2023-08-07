//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/30.
//

import Foundation


extension ReminderViewController {
    /// 데이터 소스는 사용자가 미리 알림의 세부 정보를 볼 때 "View"라는 단일 섹션에 정보를 제공
    /// 사용자가 미리 알림의 세부 정보를 편집할 때 세 개의 개별 섹션에 데이터를 제공하며, 각 섹션에는 미리 알림의 속성 중 하나를 편집할 수 있는 컨트롤이 포함되어 있음
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes
        
        var name: String {
            switch self {
            case .view: return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
