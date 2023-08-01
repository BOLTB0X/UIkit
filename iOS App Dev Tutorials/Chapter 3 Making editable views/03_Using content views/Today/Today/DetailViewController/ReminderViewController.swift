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
        
        // 이니셜라이저에서 목록 구성의 헤더 모드를 .firstItemInSection으로 변경
        listConfiguration.headerMode = .firstItemInSection

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
        
        // viewDidLoad()에서 내비게이션 항목의 rightBarButtonItem 속성에 editButtonItem을 할당
        // 편집 버튼을 탭하면 제목이 "편집"과 "완료" 사이에서 자동으로 전환 됌
        navigationItem.rightBarButtonItem = editButtonItem
        
        // 뷰 컨트롤러가 처음 로드될 때 이 목록에 데이터 스냅샷을 적용
        // 나중에 미리 알림 세부 항목을 편집할 때 다른 스냅샷을 적용하여 사용자 인터페이스를 업데이트하여 사용자가 변경한 사항을 반영이 필요
        //updateSnapshot()
        
        updateSnapshotForViewing()
    }
    
    // MARK: - setEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // 보기가 편집 모드로 전환되는 경우 updateSnapshotForEditing()을 호출
        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapshotForViewing() // updateSnapshotForViewing()을 호출
        }
    }
    
    // MARK: - cellRegistrationHandler
    // 셀, 인덱스 경로 및 행을 허용하는 cellRegistrationHandler 메서드
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // cellRegistrationHandler에서 section(for:) 메서드를 사용하여 인덱스 경로에서 섹션을 검색
        let section = section(for: indexPath)
        // 다른 섹션 및 행 조합에 대해 셀을 구성하려면 튜플을 사용
        switch (section, row) {
        // cellRegistrationHandler(cell:indexPath:row)에서 헤더 행과 일치하는 사례를 추가하고 헤더 행의 연결된 문자열 값을 title이라는 상수에 저장
        case (_, .header(let title)):
            // 변경
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            // ReminderViewController.swift에서 .view 사례에 대한 기존 코드를 새 defaultConfiguration 함수에 대한 호출로 변경
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        
        // cellRegistrationHandler(cell:indexPath:row:)에서 (.title, .editableText(let title))에 대한 새 사례를 추가
        case (.title, .editableText(let title)):
            // 셀 구성에 새 제목 구성을 할당
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
            
        // cellRegistrationHandler(cell:indexPath:row:)에서 새 구성 메서드를 호출하는 날짜 및 메모에 대한 사례를 추가하고 해당 출력을 관련 목록 셀 구성에 할당
        //    구성을 할당하면 변경 사항을 반영하도록 사용자 인터페이스가 업데이트
        case (.date, .editableDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.notes, .editableText(let notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default:
            fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .todayPrimaryTint
    }
    
    // MARK: - updateSnapshotForEditing
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .notes])
        // updateSnapshotForEditing()의 .title 섹션에 .editableText 항목을 추가
        snapshot.appendItems([.header(Section.title.name), .editableText(reminder.title)], toSection: .title)
        // updateSnapshotForEditing에서 알림 날짜 및 메모에 대한 항목을 추가
        snapshot.appendItems([.header(Section.date.name), .editableDate(reminder.dueDate)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name), .editableText(reminder.notes)], toSection: .notes)
        dataSource.apply(snapshot)
    }
    
    // MARK: - updateSnapshotForViewing
    private func updateSnapshotForViewing() {
        // 스냅샷은 데이터의 현재 상태를 나타냄
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        // updateSnapshotForViewing()에서 빈 헤더 항목을 스냅샷 항목의 첫 번째 요소로 삽입
        snapshot.appendItems([Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
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
