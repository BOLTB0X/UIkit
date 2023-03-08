//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/03/03.
//

import Foundation

// 섹션 및 항목 식별자 유형은 데이터 소스가 해시 값을 사용하여 데이터의 변경 사항을 결정하므로 Hashable을 준수해야 함
extension ReminderViewController {
    enum Section: Int, Hashable {
        // 보기, 제목, 날짜 및 메모에 대한 사례를 추가
        // 데이터 소스는 사용자가 미리 알림의 세부 정보를 볼 때 "보기"라는 단일 섹션에 정보를 제공할 것
        // 사용자가 미리 알림의 세부 정보를 편집할 때 세 개의 개별 섹션에 데이터를 제공하며, 각 섹션에는 미리 알림의 속성 중 하나를 편집할 수 있는 컨트롤이 포함되어 있음
        case view
        case title
        case date
        case notes
        
        // 각 섹션의 제목 텍스트를 계산하는 이름 속성을 만듬
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
