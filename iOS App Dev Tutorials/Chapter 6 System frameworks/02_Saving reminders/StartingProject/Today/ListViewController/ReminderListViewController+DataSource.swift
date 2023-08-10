/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>

    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }

    private var reminderStore: ReminderStore { ReminderStore.shared }

    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredReminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progress = progress
    }

    func cellRegistrationHandler(
        cell:
            UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID
    ) {
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue =
            reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }

    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }

    func updateReminder(_ reminder: Reminder) {
        do {
            try reminderStore.save(reminder)
            let index = reminders.indexOfReminder(withId: reminder.id)
            reminders[index] = reminder
        } catch TodayError.accessDenied {
        } catch {
            showError(error)
        }
    }

    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }

    // MARK: - addReminder
    func addReminder(_ reminder: Reminder) {
        var reminder = reminder
        do {
            // 미리 알림을 저장하는 do 블록을 추가하고 해당 식별자를 새 상수에 저장
            let idFromStore = try reminderStore.save(reminder)
            // 미리 알림을 배열에 추가하기 전에 수신 식별자를 미리 알림 변수에 할당
            reminder.id = idFromStore
            reminders.append(reminder)
        } catch TodayError.accessDenied { // 아무 작업도 수행하지 않는 TodayError.accessDenied에 대한 catch 블록을 추가
            // 사용자가 미리 알림에 대한 액세스를 허용하지 않도록 선택한 경우 save(_:) 메서드에서 오류가 발생
        } catch {
            showError(error)
        }
    }

    func deleteReminder(withId id: Reminder.ID) {
        do { // deleteReminder(withId:)에서 기존 코드 주위에 do 블록을 추가
            // 해당 식별자가 있는 미리 알림을 제거
            try reminderStore.remove(with: id)
            let index = reminders.indexOfReminder(withId: id)
            reminders.remove(at: index)
        } catch TodayError.accessDenied { // TodayError.accessDenied에 대한 catch 블록을 추가
        } catch {
            showError(error)
        }
    }

    func prepareReminderStore() {
        Task {
            do {
                try await reminderStore.requestAccess()
                reminders = try await reminderStore.readAll()
                // .EKEventStoreChanged 알림을 등록
                // 시스템이 이 변경 알림을 수신하면 뷰 컨트롤러에서 해당 작업 메서드를 호출
                NotificationCenter.default.addObserver(
                                    self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
            } catch TodayError.accessDenied, TodayError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleData
                #endif
            } catch {
                showError(error)
            }
            updateSnapshot()
        }
    }
    
    // MARK: - reminderStoreChanged
    func reminderStoreChanged() {
        Task {
            // readAll()의 결과를 기다리고 미리 알림에 할당
            // await 키워드는 비동기 메서드 readAll()이 완료될 때까지 작업이 일시 중단됨을 나타냄
            reminders = try await reminderStore.readAll()
            updateSnapshot()
        }
    }

    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction
    {
        let name = NSLocalizedString(
            "Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }

    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }

}
