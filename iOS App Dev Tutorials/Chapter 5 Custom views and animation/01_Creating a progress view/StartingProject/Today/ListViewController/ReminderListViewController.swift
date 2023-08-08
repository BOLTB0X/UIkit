/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData
    var listStyle: ReminderListStyle = .today
    
    var filteredReminders: [Reminder] {
        return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    let listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
    ])
    
    // add
    var headerView: ProgressHeaderView?
    var progress: CGFloat { // progress라는 계산된 프로퍼티를 추가
        // 각 미리 알림이 나타내는 FilteredReminders 배열의 비율을 계산하고 ChunkSize라는 로컬 상수에 값을 저장
        let chunkSize = 1.0 / CGFloat(filteredReminders.count)
        
        // filterReminders에서 완료된 알림의 백분율을 계산하려면 reduce(_:_:)를 사용
        let progress = filteredReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0
            return $0 + chunk
        }
        return progress
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // viewDidLoad()에서 컬렉션 뷰에 배경색을 할당
        collectionView.backgroundColor = .todayGradientFutureBegin

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        // viewDidLoad()에서 header view를 supplementary view로 등록
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
        /// 새 header view등록을 사용하는 데이터 소스에 보충 보기 공급자 클로저를 추가
        /// 이 클로저는 diff 가능한 데이터 소스에서 보충 헤더 뷰를 구성하고 반환
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }

        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString(
            "Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton

        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(
            self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl

        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }

        updateSnapshot()

        collectionView.dataSource = dataSource
    }

    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id = filteredReminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
    
    // MARK: - collectionView
    /// collectionView(_:willDisplaySupplementaryView:forElementKind:at:) 함수를 재정의
    /// 콜렉션 보기가 보충 view를 표시하려고 할 때 시스템이 이 메소드를 호출
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String, at indexPath: IndexPath
    ) {
        // 가드 문을 사용하여 요소 종류가 진행 보기인지 확인
        // 유형 캐스팅 연산자 as? UICollectionReusableView 유형에서 ProgressHeaderView로 보기를 조건부로 다운캐스트
        guard elementKind == ProgressHeaderView.elementKind,
              let progressView = view as? ProgressHeaderView
        else { // 그렇지 않으면 함수 호출 지점으로 돌아감
            return
        }
        
        // progressView의 진행률 프로퍼티를 업데이트
        // 이 변경은 headerview의 didSet 관찰자를 트리거
        progressView.progress = progress
    }

    func pushDetailViewForReminder(withId id: Reminder.ID) {
        let reminder = reminder(withId: id)
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            self?.updateReminder(reminder)
            self?.updateSnapshot(reloading: [reminder.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary // add
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
            [weak self] _, _, completion in
            self?.deleteReminder(withId: id)
            self?.updateSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - supplementaryRegistrationHandler
    // 파일 맨 아래에 진행률 헤더 view, 요소 종류 및 인덱스 경로를 허용하는 supplementaryRegistrationHandler
    private func supplementaryRegistrationHandler(
        progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath
    ) {
        // 들어오는 progressView를 headerView 프로퍼티에 할당
        headerView = progressView
    }
}
