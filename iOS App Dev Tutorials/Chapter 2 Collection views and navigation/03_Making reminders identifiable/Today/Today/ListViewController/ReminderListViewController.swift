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
        
        updateSnapshot() // 메소드 호출
        
        collectionView.dataSource = dataSource
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

