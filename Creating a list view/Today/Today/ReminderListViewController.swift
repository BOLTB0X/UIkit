//
//  ViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/22.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    // diffable 데이터 소스에 대한 유형 별칭을 추가, 유형 별칭은 보다 표현력이 뛰어난 이름으로 기존 유형을 참조하는 데 유용
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    
    // DataSource를 암시적으로 래핑 해제하는 dataSource 속성을 추가
    var dataSource: DataSource!
    // 옵셔널에 값이 있다는 것을 알고 있는 경우에만 암시적으로 언래핑된 옵셔널을 사용해야함 그렇지 않으면 앱을 즉시 종료하는 런타임 오류가 발생할 위험이 있음 그러므로 선택 사항에 값이 있음을 보장하기 위해 다음 단계에서 데이터 소스를 초기화해야함
    
    // 뷰 컨트롤러가 뷰 계층 구조를 메모리에 로드한 후 시스템은 viewDidLoad()를 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        // 컬렉션 보기 레이아웃에 목록 레이아웃을 할당
        collectionView.collectionViewLayout = listLayout
        
        // 셀 등록은 셀의 내용과 모양을 구성하는 방법을 지정
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item] // 검색할 내용을 미리
            var contentConfiguration = cell.defaultContentConfiguration() // defaultContentConfiguration()은 미리 정의된 시스템 스타일로 콘텐츠 구성을 만듬
            contentConfiguration.text = reminder.title // 목록에는 구성 텍스트가 셀의 기본 텍스트로 표시
            cell.contentConfiguration = contentConfiguration // 콘텐츠 구성을 셀에 할당
        }
        // 이니셜라이저에서 컬렉션 보기에 대한 셀을 구성하고 반환하는 클로저를 전달, 클로저는 컬렉션 뷰의 셀 위치에 대한 인덱스 경로와 항목 식별자를 허용
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            // 셀 등록을 사용하여 셀을 대기열에서 제거하고 반환, 모든 항목에 대해 새 셀을 만들 수 있지만 초기화 비용으로 인해 앱의 성능이 저하됨. 셀을 재사용하면 방대한 수의 항목이 있는 경우에도 앱이 제대로 작동할 수 있음
            return collectionView.dequeueConfiguredReusableCell(
                           using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
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

