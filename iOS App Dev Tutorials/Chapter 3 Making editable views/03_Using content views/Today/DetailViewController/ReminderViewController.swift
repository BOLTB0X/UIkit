/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    var reminder: Reminder
    private var dataSource: DataSource!

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
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
        navigationItem.rightBarButtonItem = editButtonItem

        updateSnapshotForViewing()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapshotForViewing()
        }
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
            // text(for:) 함수를 ReminderViewController.swift에서 ReminderViewController+CellConfiguration.swift로 이동
            // 이 함수는 행 유형별로 적절한 텍스트 문자열을 생성하므로 이 셀 구성 확장에서 보다 쉽게 ​​찾고 수정
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            // 기존 코드를 새 defaultConfiguration 함수에 대한 호출로 변경
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)

        default:
            fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .todayPrimaryTint
    }

    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
    }

    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems(
            [Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
    }

    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
