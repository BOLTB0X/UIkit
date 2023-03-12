//
//   ReminderListViewController+Actions.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/28.
//

import UIKit

extension ReminderListViewController {
    // @objc 특성은 Objective-C 코드에서 이 메서드를 사용할 수 있도록 함
    // 다음 섹션에서는 Objective-C API를 사용하여 메소드를 사용자 지정 버튼에 연결
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        // sender’s optional id를 id라는 상수로 Unwrap
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
