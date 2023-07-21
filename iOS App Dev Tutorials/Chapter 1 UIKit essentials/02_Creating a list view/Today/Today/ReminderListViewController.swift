//
//  ViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/21.
//

import UIKit

// MARK: - ReminderListViewController
class ReminderListViewController: UICollectionViewController {
    // 기존 유형을 참조하는 데 유용
    // DataSource를 암시적으로 래핑 해제하는 dataSource 속성을 추가
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    
    // 데이터 소스는 스냅샷으로 데이터 상태를 관리
    // 스냅샷은 특정 시점의 데이터 상태를 나타냄
    // 스냅샷을 사용하여 데이터를 표시하려면 스냅샷을 만들고 표시할 데이터 상태로 스냅샷을 채운 다음 사용자 인터페이스에서 스냅샷을 적용
    var dataSource: DataSource!
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewDidLoad() 메서드에서 새 목록 레이아웃을 만듬
        let listLayout = listLayout()
        // 컬렉션 보기 레이아웃에 목록 레이아웃을 할당
        collectionView.collectionViewLayout = listLayout
        
        // 셀 등록은 셀의 내용과 모양을 구성하는 방법을 지정
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            
            // 항목에 해당하는 미리 알림을 검색함
            let reminder = Reminder.sampleData[indexPath.item]
            // 셀의 기본 콘텐츠 구성을 검색
            // defaultContentConfiguration()은 미리 정의된 시스템 스타일로 콘텐츠 구성을 만들어줌
            var contentConfiguration = cell.defaultContentConfiguration()
            
            // 콘텐츠 구성 텍스트에 알림.제목을 할당 -> 목록에는 구성 텍스트가 셀의 기본 텍스트로 표시가 됌
            contentConfiguration.text = reminder.title
            // 콘텐츠 구성을 셀에 할당함
            cell.contentConfiguration = contentConfiguration
        }
        
        // dataSource 변수 선언
        // 이니셜라이저에서 컬렉션 보기에 대한 셀을 구성하고 반환하는 클로저를 전달함
        // 클로저는 컬렉션 뷰의 셀 위치에 대한 인덱스 경로와 항목 식별자를 허용함
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            
            // 셀 등록을 사용하여 셀을 대기열에서 제거하고 반환
            
            // 모든 항목에 대해 새 셀을 만들 수 있지만 초기화 비용으로 인해 앱의 성능이 저하
            // 셀을 재사용하면 방대한 수의 항목이 있는 경우에도 앱이 제대로 작동 가능
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        // 스냅샷을 적용하면 사용자 인터페이스의 변경 사항이 반영
        dataSource.apply(snapshot)
        
        // 콜렉션 view에 데이터 소스를 지정
        collectionView.dataSource = dataSource
    }
    
    // MARK: - listLayout
    // 그룹화된 모양으로 새 목록 구성 변수를 만드는 메소드
    private func listLayout() -> UICollectionViewCompositionalLayout {
        // UICollectionLayoutListConfiguration은 목록 레이아웃에 섹션을 만드는 용도
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // new compositional layout with the list configuration.
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

