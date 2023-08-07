//
//  ViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/22.
//

import UIKit

// MARK: - ReminderListViewController
class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    // 미리 알림 인스턴스 배열을 저장하는 미리 알림 프로퍼티를 추가
    var reminders: [Reminder] = Reminder.sampleData
    
    // today인 listStyle 프로퍼티
    var listStyle: ReminderListStyle = .today
    
    // 지정된 목록 스타일에 대한 미리 알림 컬렉션을 반환하는 FilteredReminders 계산 프로퍼티를 추가
    var filteredReminders: [Reminder] {
        // filter(_:) 메서드는 컬렉션을 반복하고 조건을 만족하는 요소만 포함하는 배열을 반환
        //return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }
        
        // 기한별로 필터링된 미리 알림을 정렬
        // sorted(by:) 메소드에 전달하는 클로저는 두 개의 미리 알림 인수의 기한을 비교하여 배열의 순서를 결정
        return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    
    let listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
    ])
    
    // MARK: - viewDidLoad
    // 뷰 컨트롤러가 뷰 계층 구조를 메모리에 로드한 후 시스템은 viewDidLoad()를 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        // 컬렉션 보기 레이아웃에 목록 레이아웃을 할당
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
                
        // MARK: - 변경 점 1
        // ReminderListViewController.swift에서 데이터 소스 초기화 프로그램의 itemIdentifier 유형을 Reminder.ID로 변경
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            // 셀 등록을 사용하여 셀을 대기열에서 제거하고 반환, 모든 항목에 대해 새 셀을 만들 수 있지만 초기화 비용으로 인해 앱의 성능이 저하됨. 셀을 재사용하면 방대한 수의 항목이 있는 경우에도 앱이 제대로 작동할 수 있음
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        // didPressAddButton(_:) 선택기를 호출하는 추가 버튼에 대한 새 UIBarButtonItem
        let addButton = UIBarButtonItem(
                   barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        // 버튼에 접근성 레이블을 추가
        addButton.accessibilityLabel = NSLocalizedString(
                    "Add reminder", comment: "Add button accessibility label")
        // 내비게이션 항목의 오른쪽 막대 버튼 항목에 버튼을 할당
        navigationItem.rightBarButtonItem = addButton
        
        // listStyle.rawValue로 설정
        // ListStyle은 원시 Int 값을 저장하므로 Swift는 각 경우에 0부터 시작하는 정수 값을 자동으로 할당
        // selectedSegmentIndex는 선택된 세그먼트의 인덱스 번호
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        
        // 세그먼트화된 컨트롤에 대한 대상 개체 및 작업 메서드를 구성
        listStyleSegmentedControl.addTarget(
                    self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        
        // 내비게이션 항목의 titleView에 목록 스타일 분할 컨트롤을 할당
        navigationItem.titleView = listStyleSegmentedControl
        
        // 앱이 iOS 16 이상에서 실행될 때 가용성 조건을 사용하여 navigationItem의 스타일을 설정
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        
        updateSnapshot() // 메소드 호출
        
        collectionView.dataSource = dataSource
    }
    
    // MARK: - collectionView
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        // collectionView(_:shouldSelectItemAt:)에서 미리 알림을 FilteredReminders로 변경
        // 필터링된 배열을 사용하려면 컬렉션 보기 위임 및 데이터 소스 메서드를 업데이트해야 함
        let id = filteredReminders[indexPath.item].id
        
        // pushDetailViewForReminder(withId:) 메서드를 호출
        // 이 메서드는 상세 view 컨트롤러를 탐색 스택에 추가하여 상세 보기가 화면에 푸시되도록 함
        pushDetailViewForReminder(withId: id)
        
        // 사용자가 선택한 항목을 탭한 항목을 표시하지 않으므로 false를 반환
        // 해당 목록 항목에 대한 세부 정보 view로 전환
        return false
    }
    
    // MARK: - pushDetailViewForReminder
    // reminder identifier를 식별하는 메소드
    func pushDetailViewForReminder(withId id: Reminder.ID) {
        // 모델의 reminder 배열에서 식별자와 일치하는 reminder을 검색하고 reminder이라는 상수에 할당
        let reminder = reminder(withId: id)
        // onChange 핸들러를 ReminderViewController 이니셜라이저에 추가
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            // 이 함수는 편집된 미리 알림으로 데이터 소스의 미리 알림 배열을 업데이트
            self?.updateReminder(reminder)
            // updateSnapshot(reloading:)을 호출
            self?.updateSnapshot(reloading: [reminder.id])
        }
        
        /// 뷰 컨트롤러를 탐색 컨트롤러 스택으로 푸시
        /// 뷰 컨트롤러가 현재 내비게이션 컨트롤러에 포함된 경우 내비게이션 컨트롤러에 대한 참조는 선택적 navigationController 프로퍼티에 저장
        /// 세부 정보 view는 제공된 식별자에 대한 reminder 세부 data를 표시, 뒤로 버튼은 탐색 표시줄의 선행 항목으로 자동으로 나타남
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - listLayout
    // 일단 return 값이 안되어 추가가 필요
    // 구분 기호를 비활성화하고 배경색을 지우도록 변경
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        
        // listLayout()에서 목록 구성의 trailingSwipeActionsConfigurationProvider를 makeSwipeActions로 설정
        // 목록 구성에는 사용자가 셀의 앞쪽 가장자리를 살짝 밀 때 표시할 작업을 제공하는 leadingSwipeActionsConfigurationProvider
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions

        
        listConfiguration.backgroundColor = .clear
        
        // 목록 구성으로 새로운 컴포지션 레이아웃 반환
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    // MARK: - makeSwipeActions
    // IndexPath를 수락하고 선택적 UISwipeActionsConfiguration을 반환하는 makeSwipeActions(for:) 함수
    // 각 스와이프 동작 구성 개체에는 사용자가 왼쪽 또는 오른쪽 스와이프하여 수행할 수 있는 동작을 정의하는 UIContextualAction 개체 집합이 포함되어 있음
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        // 작업의 제목을 만들고 사용자가 행을 스와이프하면 컬렉션 보기에 구성의 각 작업에 대한 버튼이 표시
        // 버튼의 레이블은 작업의 제목
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        
        // deleteAction이라는 UIContextualAction을 만듭니다. 조치가 데이터를 삭제하므로 파괴적 스타일을 지정
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
            [weak self] _, _, completion in
            self?.deleteReminder(withId: id)
            self?.updateSnapshot()
            completion(false)
        }
        // 삭제 작업을 사용하여 새 스와이프 작업 구성 개체를 반환
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

