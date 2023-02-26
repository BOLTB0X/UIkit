//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/25.
//

import UIKit

// ReminderListViewController가 미리 알림 목록에 대한 데이터 소스로 작동하도록 하는 모든 동작이 포함됌
extension ReminderListViewController {
    // 유형 별칭 정의를 ReminderListViewController.swift에서 ReminderListViewController+DataSource.swift로 이동
    // 이러한 유형을 사용하면 미리 알림 데이터에 대한 비교 가능한 데이터 소스 및 스냅샷을 정의할 수 있음
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // 목록은 둘 이상의 데이터 유형에 대한 셀을 표시할 수 있습니다. 아래 컬렉션 뷰에 첫 번째 셀 유형을 등록
    
    // 셀, 인덱스 경로 및 ID를 허용하는 cellRegistrationHandler라는 메서드를 만듭
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        // ReminderListViewController.swift의 셀 등록 클로저에서 콘텐츠를 추출하고 ReminderListViewController+DataSource.swift의 새 메서드에 삽입
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        // 목록에 셀을 등록하는 것 외에도 표시되는 정보를 구성하고 셀 등록 방법을 사용하여 셀을 포맷
        // 8단계 ReminderListViewController+DataSource.swift에서 미리 알림 기한의 dayAndTimeText를 콘텐츠 구성의 보조 텍스트에 할당
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        // 보조 텍스트의 글꼴을 .caption1로 변경
        // 미리 알림 제목에 더 많은 주의를 끌기 위해 날짜와 시간을 덜 강조
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        // 셀 등록 처리기에서 새 단추 구성 메서드를 호출하여 미리 알림을 전달하고 결과를
        // doneButtonConfiguration이라는 새 변수에 할당
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        // 완료 버튼 구성의 tintColor 속성에 .todayListCellDoneButtonTint를 할당
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        // 셀 액세서리의 배열을 만들고 셀의 액세서리 속성에 할당
        // 배열에는 완료 버튼 구성과 상시 공개 표시기를 사용하여 구성된 사용자 지정 보기가 포함
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        // .listGroupCell() 백그라운드 구성을 backgroundConfiguration이라는 변수에 할당
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        // .todayListCellBackground 색상을 배경 구성의 backgroundColor 속성에 할당
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        // 셀의 backgroundConfiguration 속성에 새 배경 구성을 할당
        // 제공된 배경색 자산을 사용하면 기본 배경색에서 모양이 변경 x 다음 섹션에서 이 걸 수정한다함
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    // 미리 알림을 수락하고 CustomViewConfiguration을 반환하는 doneButtonConfiguration
    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        // 삼항 조건 연산자를 사용하여 "circle.fill" 또는 "circle"을 symbolName이라는 상수에 할당
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        // .title1 텍스트 스타일을 사용하여 새 이미지 기호 구성을 만들고 그 결과를 symbolConfiguration이라는 상수에 할당
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        // 기호 구성을 사용하여 새 이미지를 만들고 그 결과를 이미지라는 상수에 할당
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        // 새 버튼을 만들고 그 결과를 버튼이라는 상수에 할당
        // 버튼이 미리 알림의 완료 상태를 시각적으로 나타내는 역할
        let button = UIButton()
        // 버튼의 .normal 상태에 대한 이미지를 할당
        // 정상 상태일 때 하나의 이미지를 표시하고 강조 표시되었을 때 다른 이미지를 표시하도록 UIButton 객체를 구성 가능
        button.setImage(image, for: .normal)
        
        // 버튼을 사용하여 사용자 지정 보기 구성을 만들고 결과를 반환
        // 이 구성 이니셜라이저를 사용하면 셀의 콘텐츠 보기 외부에서 셀 액세서리가 셀의 선행 또는 후행 가장자리에 표시되는지 여부를 정의 가능
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}
