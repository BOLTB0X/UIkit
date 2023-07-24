//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/24.
//

import UIKit

// Collection view가 목록에 항목을 표시하는 데 사용하는 셀을 만들고 구성 관련 코드
// ReminderListViewController가 미리 알림 목록에 대한 데이터 소스로 작동하도록 하는 모든 동작이 포함
extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // MARK: - cellRegistrationHandler
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        // 미리 알림 기한의 dayAndTimeText를 콘텐츠 구성의 보조 텍스트에 할당
        contentConfiguration.text = reminder.title
        // 보조 텍스트의 글꼴을 .caption1로 변경
        // 미리 알림 제목에 더 많은 주의를 끌기 위해 날짜와 시간을 덜 강조
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        // 버튼 관련 추가
        // 셀 등록 처리기에서 새 버튼 구성 메서드를 호출하여 미리 알림을 전달하고 결과를 doneButtonConfiguration이라는 새 변수에 할당
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        // 완료 버튼 구성의 tintColor 속성에 .todayListCellDoneButtonTint를 할당
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint

        // 셀 액세서리의 배열을 만들고 셀의 액세서리 속성에 할당
        // 배열에는 완료 버튼 구성과 상시 공개 표시기를 사용하여 구성된 사용자 지정 보기가 포함되어 있음
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        // .listGroupCell() 백그라운드 구성을 backgroundConfiguration이라는 변수에 할당
        // todayListCellBackground 색상을 배경 구성의 backgroundColor 속성에 할당
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
               backgroundConfiguration.backgroundColor = .todayListCellBackground
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration

    }
    
    // MARK: - doneButtonConfiguration
    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))

    }
}
