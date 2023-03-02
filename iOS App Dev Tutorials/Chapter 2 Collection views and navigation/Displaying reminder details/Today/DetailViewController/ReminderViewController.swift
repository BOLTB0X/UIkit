//
//  ReminderViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/03/01.
//

import UIKit

// 미리 알림 세부 정보 목록을 배치하고 목록에 미리 알림 세부 정보 데이터를 제공
class ReminderViewController: UICollectionViewController {
    // Int 및 Row 일반 매개변수를 지정하여 데이터 소스가 섹션 번호에 대해 Int 인스턴스를 사용하고 목록 행에 대해 이전 섹션에서 정의한 사용자 정의 열거인 Row의 인스턴스를 사용하도록 컴파일러에 지시
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    
    //  Int 및 Row 일반 매개변수를 지정하여 스냅샷이 섹션 번호에 Int 인스턴스를 사용하고 목록의 항목에 Row 인스턴스를 사용하도록 컴파일러에 지시
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>

    var reminder: Reminder
    private var dataSource: DataSource!
    
    // 알림을 수락하고 속성을 초기화하는 이니셜라이저
    init(reminder: Reminder) {
        self.reminder = reminder
        // .insetGrouped 모양을 사용하여 목록 구성을 만들고 그 결과를 listConfiguration이라는 변수에 할당
        // 몇 가지 사용자 지정 예외를 제외하고 대부분의 모양과 스타일에 대해 기본 구성을 사용
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // 목록 구성에서 구분 기호를 비활성화하여 목록 셀 사이의 줄을 제거
        listConfiguration.showsSeparators = false

        // 목록 구성을 사용하여 구성 목록 레이아웃을 만들고 그 결과를 listLayout이라는 상수에 할당
        // 목록 구성 레이아웃에는 목록에 필요한 레이아웃 정보만 포함되어 있음
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        // 새 목록 레이아웃을 전달하는 수퍼클래스의 init(collectionViewLayout:)을 호출
        // 클래스 상속 및 초기화에서 Swift 하위 클래스는 초기화 중에 상위 클래스의 지정된 이니셜라이저 중 하나를 호출해야 함
        super.init(collectionViewLayout: listLayout)
    }
    // NSCoding에 필요한 실패할 수 있는 초기화 프로그램
    // init(coder:)를 포함하면 요구 사항을 충족
    // 오늘 코드에서만 미리 알림 보기 컨트롤러를 만들기 때문에 앱은 이 이니셜라이저를 사용 X
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    // viewDidLoad를 재정의
    // 뷰 컨트롤러의 수명 주기 메서드를 재정의할 때 먼저 슈퍼클래스가 사용자 지정 작업을 수행하기 전에 자체 작업을 수행할 수 있는 기회를 제공
    override func viewDidLoad() {
        super.viewDidLoad()
        // 이 섹션의 앞부분에서 만든 처리기를 사용하여 새 셀 등록을 만들고 그 결과를 cellRegistration이라는 상수에 할당
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        // 앱의 목록은 잠재적으로 화면에 표시할 수 있는 것보다 더 많은 항목을 포함할 수 있음
        // 불필요한 셀 생성을 방지하기 위해 시스템은 셀이 화면 밖으로 이동한 후 재활용할 컬렉션 셀 대기열을 유지
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        updateSnapshot()

    }
    
    // 셀, 인덱스 경로 및 행을 허용하는 cellRegistrationHandler 메서드
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // 셀의 기본 구성을 contentConfiguration이라는 변수에 할당
        // 구성은 행에 기본 스타일을 할당
        var contentConfiguration = cell.defaultContentConfiguration()
        // 행에 적합한 텍스트 및 글꼴을 구성
        // text(for:) 함수를 사용하여 데이터를 제공하고 이전 섹션에서 정의한 행의 textStyle 계산 변수를 사용하여 글꼴 스타일을 제공
        contentConfiguration.text = text(for: row)
               contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        // 이전 섹션에서 정의한 행의 이미지 계산 변수를 구성의 이미지 속성에 할당
        contentConfiguration.image = row.image
        // 셀의 contentConfiguration 속성에 구성을 할당
        cell.contentConfiguration = contentConfiguration
        // .todayPrimaryTint를 셀의 tintColor 속성에 할당
        cell.tintColor = .todayPrimaryTint

    }

    // 주어진 행과 관련된 텍스트를 반환하는 text(for:)라는 함수
    // if 문을 사용하여 관련 스타일 적용에 대한 세부 정보를 구분도 가능
    // 각 행을 열거형의 개별 사례로 설명함으로써 각 행을 더 쉽게 수정하고 나중에 더 많은 미리 알림 세부 정보를 추가 가능
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
    
    private func updateSnapshot() {
        // 새 스냅샷을 생성하고 스냅샷이라는 변수에 할당
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        // 4개의 행 인스턴스를 스냅샷에 대한 항목으로 제공
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        // 스냅샷을 데이터 소스에 적용
        // 스냅샷을 적용하면 사용자 인터페이스가 업데이트되어 스냅샷의 데이터와 스타일이 반영
        dataSource.apply(snapshot)

      }
}
