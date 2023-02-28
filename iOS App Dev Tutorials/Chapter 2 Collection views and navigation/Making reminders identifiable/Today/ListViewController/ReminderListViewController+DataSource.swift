/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

extension ReminderListViewController {
    // ReminderListViewController+DataSource.swift에서 데이터 소스의 항목 식별자 유형과 스냅샷 유형 별칭을 Reminder.ID로 변경
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>

    // 미리 알림 목록 보기 컨트롤러의 viewDidLoad() 메서드에서 이전 단계에서 생성한 메서드로 스냅샷 코드를 추출
    // 업데이트할 미리 알림 식별자 배열을 허용하도록 updateSnapshot()을 수정
    // 빈 배열을 매개 변수의 기본값으로 지정하면 식별자를 제공하지 않고 viewDidLoad()에서 메서드를 호출
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map { $0.id })
        // 배열 비어 있지 않으면 식별자에 대한 미리 알림을 다시 로드하도록 스냅샷에 지시
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }

    
    func cellRegistrationHandler(
        cell:
        // cellRegistrationHandler 매개 변수 목록의 식별자 유형을 Reminder.ID로 변경
        UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID
    ) {
        //  메서드를 사용하여 제공된 ID로 미리 알림을 검색하도록 셀 등록 핸들러를 업데이트
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    // 알림 식별자를 수락하고 알림 배열에서 해당 알림을 반환하는 알림(withId:)이라는 메서드
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    // 미리 알림을 수락하고 해당 배열 요소를 미리 알림 내용으로 업데이트하는 updateReminder(_:)라는 메서드
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }

    // Reminder.ID를 사용하여 모델에서 미리 알림을 가져옴
    func completeReminder(withId id: Reminder.ID) {
        // 알림(withId:)을 호출하여 알림을 가져옴
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder) // updateReminder(_:)를 호출하여 모델에서 미리 알림을 업데이트
        // 앱을 빌드 및 실행하고 완료 버튼을 탭하여 미리 알림의 완료 상태를 변경
        // completeReminder(withId:)에서 스냅샷을 업데이트할 때 미리 알림의 식별자를 전달
        updateSnapshot(reloading: [id])
    }

    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
    
       // 미리 알림의 식별자를 버튼의 id 속성에 할당
        let button = ReminderDoneButton()
        // addTarget(_:action:for:)을 호출하여 버튼의 .touchUpInside 이벤트를 didPressDoneButton(_:) 액션 메서드에 연결
        // 컴파일하는 동안 시스템은 대상인 ReminderListViewController에 didPressDoneButton(_:) 메서드가 있는지 확인
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}
