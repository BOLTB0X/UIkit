/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

class ReminderViewController: UICollectionViewController {
    // Int 대신 Section을 사용하도록 DataSource 및 Snapshot 별칭을 변경
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        // 이니셜라이저에서 목록 구성의 헤더 모드를 .firstItemInSection으로 변경
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        // viewDidLoad()에서 내비게이션 항목의 rightBarButtonItem 속성에 editButtonItem을 할당
        // 편집 버튼을 탭하면 제목이 "편집"과 "완료" 사이에서 자동으로 전환
        navigationItem.rightBarButtonItem = editButtonItem
        
        // updateSnapshot()을 Control-클릭하고 Refactor > Rename을 선택한 다음 함수 이름을 updateSnapshotForViewing으로 변경
        updateSnapshotForViewing()
    }
    
    // setEditing(_:animated:)을 재정의하고 슈퍼클래스의 구현을 호출
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // 보기가 편집 모드로 전환되는 경우 업데이트SnapshotForEditing()을 호출합
        if editing {
            updateSnapshotForEditing()
        } else { // updateSnapshotForViewing()을 호출
            updateSnapshotForViewing()
        }
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // 인덱스 경로에서 섹션을 검색 == section(for:)
        let section = section(for: indexPath)
        // 다른 섹션 및 행 조합에 대해 셀을 구성하려면 튜플을 사용하여 switch 문을 추가
        switch (section, row) {
        // cellRegistrationHandler(cell:indexPath:row)에서 헤더 행과 일치하는 사례를 추가하고 헤더 행의 연결된 문자열 값을 title이라는 상수에 저장
        // 이 경우는 모든 섹션의 제목을 구성
        case (_, .header(let title)):
            // 셀의 기본 구성을 검색하고 변수에 저장
            var contentConfiguration = cell.defaultContentConfiguration()
            // 콘텐츠 구성의 text 속성에 제목을 지정
            contentConfiguration.text = title
            // 셀의 contentConfiguration 속성에 새 구성을 할당
            cell.contentConfiguration = contentConfiguration

        // .view 섹션의 모든 행과 일치하는 사례를 추가
        case (.view, _):
            // tint 색상 관련 줄을 제외한 기존 셀 구성 코드를 .view 케이스 본문으로 이동
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
        default:
            //  switch 문이 예기치 않은 행이나 섹션을 일치시키려고 시도하는 경우 기본 사례에서 fatalError(_:file:line:)를 호출
            // 튜플을 사용하여 섹션 및 행 값을 switch 문과 함께 사용할 수 있는 단일 복합 값으로 그룹화
            fatalError("Unexpected combination of section and row.")
        }
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil // nil을 반환하는 기본 사례를 text(for:)에 추가
        }
    }
    
    // updateSnapshotForEditing() 함수를 만들고 새 스냅샷을 초기화
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        // .title, .date 및 .notes 추가
        snapshot.appendSections([.title, .date, .notes])
        // cellRegistrationHandler에서 section(for:) 메서드를 사용하여 인덱스 경로에서 섹션을 검색
        // updateSnapshotForEditing()에서 각 섹션에 헤더 항목을 추가
        // name 속성은 헤더에 표시할 각 사례에 대한 로케일 인식 문자열을 계산
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
    }
    
    // 스냅샷은 데이터의 현재 상태를 보여줌
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        // updateSnapshotForViewing()에서 빈 헤더 항목을 스냅샷 항목의 첫 번째 요소로 삽입
        snapshot.appendItems(
            [Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        // .view 섹션을 추가하도록 updateSnapshot() 메서드를 수정
        // 컨트롤러가 보기 모드인 경우 이 방법을 사용하여 스냅샷을 구성
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    // 인덱스 경로를 받아들이고 섹션을 반환하는 section(for:) 함수
    private func section(for indexPath: IndexPath) -> Section {
        // 인덱스 경로를 사용하여 섹션 번호를 생성
        // 보기 모드에서는 모든 항목이 섹션 0에 표시
        // 편집 모드에서는 제목, 날짜 및 메모가 각각 섹션 1, 2 및 3으로 구분
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        
        // 섹션 번호를 사용하여 섹션 인스턴스를 만듬
        // 원시 값으로 정의된 Swift 열거형에는 제공된 원시 값이 정의된 범위를 벗어나는 경우 nil을 반환하는 실패할 수 있는 초기화가 있음
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
