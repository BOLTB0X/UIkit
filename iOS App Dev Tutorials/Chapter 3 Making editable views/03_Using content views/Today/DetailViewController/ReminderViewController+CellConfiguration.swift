//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/03/08.
//

import UIKit

// ReminderViewController 클래스를 확장
extension ReminderViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row)
    -> UIListContentConfiguration
    {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    // ReminderViewController+CellConfiguration.swift에서 셀과 제목을 수락하고 UIListContentConfiguration을 반환하는 headerConfiguration(for: with:) 메소드
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String)
    -> UIListContentConfiguration
    {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    // ReminderViewController+CellConfiguration.swift로 이동
    // 행 유형별로 적절한 텍스트 문자열을 생성
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil
        }
    }
}
