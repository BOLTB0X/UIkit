//
//  ReminderViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/27.
//

import UIKit

// MARK: - ReminderViewController
class ReminderViewController: UICollectionViewController {
    // enum형 선언했던 거로 typealias 변경
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        // .insetGrouped 모양을 사용하여 목록 구성을 만들고 그 결과를 listConfiguration이라는 변수에 할당
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // 목록 구성에서 구분 기호를 비활성화하여 목록 셀 사이의 줄을 제거
        listConfiguration.showsSeparators = false
        
        // 목록 구성을 사용하여 구성 목록 레이아웃을 만들고 그 결과를 listLayout이라는 상수에 할당
        // 목록 구성 레이아웃에는 목록에 필요한 레이아웃 정보만 포함되어 있음
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
        // 새 목록 레이아웃을 전달하는 수퍼클래스의 init(collectionViewLayout:)을 호출
        // 클래스 상속 및 초기화에서 Swift 하위 클래스는 초기화 중에 상위 클래스의 지정된 이니셜라이저 중 하나를 호출해야 함
        super.init(collectionViewLayout: listLayout)
        
        /// Interface Builder는 생성한 보기 컨트롤러의 아카이브를 저장
        /// 뷰 컨트롤러에는 init(coder:) 초기화 프로그램이 필요하므로 시스템에서 이러한 아카이브를 사용하여 초기화 가능
        /// 뷰 컨트롤러를 디코딩 및 구성할 수 없으면 초기화가 실패할 것.
        ///  실패할 수 있는 이니셜라이저를 사용하여 개체를 생성할 때 결과는 성공하면 초기화된 개체를 포함하고 초기화가 실패하면 nil을 포함하는 선택적임
    }
    
    // failable initializer -> NSCoding에 필요하다함
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    // MARK: - viewDidLoad
    // 뷰 컨트롤러의 수명 주기 메서드를 재정의할 때 먼저 슈퍼클래스가 사용자 지정 작업을 수행하기 전에 자체 작업을 수행할 수 있는 기회를 제공
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이 섹션의 앞부분에서 만든 처리기를 사용하여 새 셀 등록을 만들고 그 결과를 cellRegistration이라는 상수에 할당
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        // 재사용 가능한 셀을 대기열에서 빼는 새 데이터 소스를 만들고 결과를 dataSource에 할당
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        if #available(iOS 16, *) {
            // .navigator 스타일은 제목을 중앙에 가로로 배치하고 왼쪽에 뒤로 버튼을 포함
            navigationItem.style = .navigator
        }
        
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        
        // 뷰 컨트롤러가 처음 로드될 때 이 목록에 데이터 스냅샷을 적용
        // 나중에 미리 알림 세부 항목을 편집할 때 다른 스냅샷을 적용하여 사용자 인터페이스를 업데이트하여 사용자가 변경한 사항을 반영이 필요
        updateSnapshot()
    }
    
    // MARK: - cellRegistrationHandler
    // 셀, 인덱스 경로 및 행을 허용하는 cellRegistrationHandler 메서드
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // 셀의 기본 구성을 contentConfiguration이라는 변수에 할당
        //행에 기본 스타일을 할당하는 것
        var contentConfiguration = cell.defaultContentConfiguration()
        
        /// 행에 적합한 텍스트 및 글꼴을 구성
        /// 여기서 text(for:) 함수를 사용하는 것운 데이터를 제공하고 이전 섹션에서 정의한 행의 textStyle 계산 변수를 사용하여 글꼴 스타일을 제공
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        
        // 행의 이미지 계산 변수를 구성의 이미지 속성에 할당
        contentConfiguration.image = row.image
        // 기본 콘텐츠 및 스타일에 사용자 지정을 추가했으므로 컬렉션 보기 셀에 사용자 지정 구성을 적용
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }
    
    // MARK: - text
    // 주어진 행과 관련된 텍스트를 반환하는 text(for:) 함수
    func text(for row: Row) -> String? {
        /// if 문을 사용하여 관련 스타일 적용에 대한 세부 정보를 구분할 수 있음
        /// 그러나 각 행을 열거형의 개별 사례로 설명함으로써 각 행을 더 쉽게 수정하고 나중에 더 많은 미리 알림 세부 정보를 추가 가능
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
    
    // MARK: - updateSnapshot
    private func updateSnapshot() {
        var snapshot = Snapshot()
        // 컨트롤러가 보기 모드인 경우 이 방법을 사용하여 스냅샷을 구성
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        // 스냅샷을 데이터 소스에 적용함
        // 스냅샷을 적용하면 사용자 인터페이스가 업데이트되어 스냅샷의 데이터와 스타일이 반영 됨
        dataSource.apply(snapshot)
    }
    
    // MARK: - section
    // 인덱스 경로를 받아들이고 섹션을 반환하는 section(for:) 함수
    private func section(for indexPath: IndexPath) -> Section {
        // 인덱스 경로를 사용하여 섹션 번호를 생성
        // 보기 모드에서는 모든 항목이 섹션 0에 표시됩니다. 편집 모드에서는 제목, 날짜 및 메모가 각각 섹션 1, 2 및 3으로 구분
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        
        guard let section = Section(rawValue: sectionNumber) else {
                    fatalError("Unable to find matching section")
                }
        
        return section
    }
}
