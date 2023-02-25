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
    }
}
