//
//  Controller+CellConfiguration.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

extension ReminderViewController {
    // MARK: - defaultConfiguration
    // 셀과 행을 accept하고 UIListContentConfiguration을 반환하는 defaultConfiguration(for:at:)
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row)
    -> UIListContentConfiguration
    {
        // cell.contentConfiguration 할당을 제외한 ReminderViewController의 .view 내용을 ReminderViewController+CellConfiguration.swift에서 새로 생성된 함수로 이동
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    // MARK: - headerConfiguration
    // eminderViewController+CellConfiguration.swift에서 셀과 제목을 수락하고 UIListContentConfiguration을 반환하는 headerConfiguration(for:with:)
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String)
    -> UIListContentConfiguration
    {
        // cell.contentConfiguration 할당을 제외하고 ReminderViewController의 .header 케이스 내용을 ReminderViewController+CellConfiguration.swift에서 새로 생성된 함수로 이동
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        
        return contentConfiguration
    }
    
    // MARK: - titleConfiguration
    // ReminderViewController+CellConfiguration.swift에서 셀과 제목을 수락하고 TextFieldContentView.Configuration을 반환하는 titleConfiguration(for:with:) 함수를 추가
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?)
    -> TextFieldContentView.Configuration
    {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        // workingReminder에 새 제목을 할당하는 onChange 핸들러를 추가
        contentConfiguration.onChange = { [weak self] title in
            self?.workingReminder.title = title
        }
        return contentConfiguration
    }
    
    // MARK: - dateConfiguration
    // 알림 날짜에 대한 날짜 선택기 구성 메소드
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date)
    -> DatePickerContentView.Configuration
    {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        // workingReminder에 새 날짜를 할당하는 onChange 핸들러를 추가
        contentConfiguration.onChange = { [weak self] dueDate in
            self?.workingReminder.dueDate = dueDate
        }
        return contentConfiguration
    }

    // MARK: - notesConfiguration
    // 알림 메모에 대한 텍스트 view 구성을 생성하고 반환하는 함수
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?)
    -> TextViewContentView.Configuration
    {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        return contentConfiguration
    }
    
    // MARK: - text
    // 주어진 행과 관련된 텍스트를 반환하는 text(for:) 함수
    func text(for row: Row) -> String? {
        /// if 문을 사용하여 관련 스타일 적용에 대한 세부 정보를 구분할 수 있음
        /// 그러나 각 행을 열거형의 개별 사례로 설명함으로써 각 행을 더 쉽게 수정하고 나중에 더 많은 미리 알림 세부 정보를 추가 가능
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil // default case 추가
        }
    }
}
