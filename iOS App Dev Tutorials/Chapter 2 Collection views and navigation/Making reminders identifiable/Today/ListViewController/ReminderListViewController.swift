/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    // 미리 알림 인스턴스 배열을 저장하는 미리 알림 속성을 추가
    // 샘플 데이터로 어레이를 초기화
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) {
            // ReminderListViewController.swift에서 데이터 소스 초기화 프로그램의 itemIdentifier 유형을 Reminder.ID로 변경
            // Reminder.ID는 식별 가능한 프로토콜의 관련 유형 -> Reminder의 경우 String의 유형 별칭입
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

//        var snapshot = Snapshot()
//        snapshot.appendSections([0])
//        // 미리 알림 배열을 사용하여 스냅샷을 구성
//        // 식별자 배열을 생성하려면 title 대신 id 속성에 매핑
//        snapshot.appendItems(reminders.map { $0.id })
//        dataSource.apply(snapshot)
        // ReminderListViewController+DataSource.swift에서 completeReminder(withId:)의 updateSnapshot()을 호출
        updateSnapshot()

        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
