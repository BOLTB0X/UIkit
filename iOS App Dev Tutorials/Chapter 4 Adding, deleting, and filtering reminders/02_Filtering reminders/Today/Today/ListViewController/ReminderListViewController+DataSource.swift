//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/24.
//

import UIKit

// Collection view가 목록에 항목을 표시하는 데 사용하는 셀을 만들고 구성 관련 코드
// ReminderListViewController가 미리 알림 목록에 대한 데이터 소스로 작동하도록 하는 모든 동작이 포함
extension ReminderListViewController {
    // MARK: - 변경 점 3
    // 스냅샷 유형 별칭을 Reminder.ID로 변경
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }

    
    // MARK: - updateSnapshot
    // updateSnapshot(reloading:)의 매개변수 이름을 ids에서 idsThatChanged로 변경
    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
        // idsThatChanged를 필터링하여 FilteredReminders 배열의 미리 알림에 해당하는 식별자만 포함하고 결과를 ids라는 상수에 할당
        // contains(where:)는 시퀀스에 주어진 요소가 포함되어 있는지 여부를 나타내는 부울 값을 반환
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        // 미리 알림을 식별 가능하게 만들기에서 또 다른 고차 함수인 map(_:)을 사용하여 미리 알림 배열을 식별자 배열로 변환
        snapshot.appendItems(filteredReminders.map { $0.id })
        
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    // MARK: - cellRegistrationHandler
    // 매개 변수 변경
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        //let reminder = reminders[indexPath.item]
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        // 미리 알림 기한의 dayAndTimeText를 콘텐츠 구성의 보조 텍스트에 할당
        contentConfiguration.text = reminder.title
        // 보조 텍스트의 글꼴을 .caption1로 변경
        // 미리 알림 제목에 더 많은 주의를 끌기 위해 날짜와 시간을 덜 강조
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        // 버튼 관련 추가
        // 셀 등록 처리기에서 새 버튼 구성 메서드를 호출하여 미리 알림을 전달하고 결과를 doneButtonConfiguration이라는 새 변수에 할당
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        // 완료 버튼 구성의 tintColor 속성에 .todayListCellDoneButtonTint를 할당
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        // n 셀 등록 처리기에서 셀의 액세스 가능성CustomActions 배열을 사용자 지정 작업의 인스턴스로 설정
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        // 다음으로 버튼에 accessibilityValue를 추가합니다. 각 미리 알림의 완료 상태에 대해 현지화된 문자열을 계산하여 시작
        
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        
        // 셀 액세서리의 배열을 만들고 셀의 액세서리 속성에 할당
        // 배열에는 완료 버튼 구성과 상시 공개 표시기를 사용하여 구성된 사용자 지정 보기가 포함되어 있음
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        // .listGroupCell() 백그라운드 구성을 backgroundConfiguration이라는 변수에 할당
        // todayListCellBackground 색상을 배경 구성의 backgroundColor 속성에 할당
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
               backgroundConfiguration.backgroundColor = .todayListCellBackground
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration

    }
    
    // MARK: - reminder
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }

    // MARK: - updateReminder
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    // MARK: - completeReminder
    // Reminder.ID를 사용하여 모델에서 미리 알림을 가져옴
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    // MARK: - addReminder
    // 미리 알림 배열에 미리 알림을 추가하는 addReminder(_:) 메서드
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    // MARK: - deleteReminder
    // 지정된 식별자를 가진 알림을 제거하는 deleteReminder
    func deleteReminder(withId id: Reminder.ID) {
        let index = reminders.indexOfReminder(withId: id)
        reminders.remove(at: index)
    }

    // MARK: - doneButtonAccessibilityAction
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction
    {
        let name = NSLocalizedString(
                    "Toggle completion", comment: "Reminder done button accessibility label")
        // 클로저의 캡처 목록에서 self를 약하게 캡처
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        
        return action
    }
    
    // MARK: - doneButtonConfiguration
    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        // 미리 알림의 식별자를 버튼의 id 속성에 할당
        let button = ReminderDoneButton()
        // MARK: - 중요
        // addTarget(_:action:for:)을 호출하여 버튼의 .touchUpInside 이벤트를 didPressDoneButton(_:) 액션 메서드에 연결
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)


        button.id = reminder.id
        button.setImage(image, for: .normal)
        
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))

    }
}
