/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        updateSnapshot()

        collectionView.dataSource = dataSource
    }
    
    // collectionView(_:shouldSelectItemAt:)를 재정의하고 false를 반환
    // 사용자가 선택한 항목을 탭한 항목을 표시하지 않으므로 false를 반환
    // 대신 해당 목록 항목에 대한 세부 정보 보기로 전환
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        // 이 인덱스 경로와 관련된 미리 알림의 식별자를 검색하고 id라는 상수에 할당
        // indexPath의 항목 요소는 Int이므로 이를 배열 인덱스로 사용하여 적절한 미리 알림을 검색
        let id = reminders[indexPath.item].id
        // pushDetailViewForReminder(withId:) 메서드를 호출
        // 이 메서드는 상세 보기 컨트롤러를 탐색 스택에 추가하여 상세 보기가 화면에 푸시되도록
        // 세부 정보 보기는 제공된 식별자에 대한 미리 알림 세부 정보를 표시
        pushDetailViewForReminder(withId: id)

        return false
    }
    
    // 알림 식별자를 허용하는 pushDetailViewForReminder(withId:) 함수
    func pushDetailViewForReminder(withId id: Reminder.ID) {
        // 모델의 미리 알림 배열에서 식별자와 일치하는 미리 알림을 검색하고 미리 알림이라는 상수에 할당
        let reminder = reminder(withId: id)
        // 새 디테일 컨트롤러를 만들고 이를 viewController라는 상수에 할당
        let viewController = ReminderViewController(reminder: reminder)
        // 뷰 컨트롤러를 탐색 컨트롤러 스택으로 푸시
        // 뷰 컨트롤러가 현재 내비게이션 컨트롤러에 포함된 경우 내비게이션 컨트롤러에 대한 참조는 선택적 navigationController 속성에 저장
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
