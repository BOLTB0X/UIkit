//
//  ReminderViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/03/01.
//

import UIKit

// 미리 알림 세부 정보 목록을 배치하고 목록에 미리 알림 세부 정보 데이터를 제공
class ReminderViewController: UICollectionViewController {
    var reminder: Reminder
    
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

}
