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
        // 이 인덱스 경로와 관련된 reminder의 식별자를 검색하고 id라는 상수에 할당함
        // 즉 indexPath의 항목 요소는 Int이므로 이를 배열 인덱스로 사용하여 적절한 reminder을 검색 가능
        let id = reminders[indexPath.item].id
        
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
    
    // 일단 return 값이 안되어 추가가 필요
    // 구분 기호를 비활성화하고 배경색을 지우도록 변경
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // 목록 구성으로 새로운 컴포지션 레이아웃 반환
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    
}

