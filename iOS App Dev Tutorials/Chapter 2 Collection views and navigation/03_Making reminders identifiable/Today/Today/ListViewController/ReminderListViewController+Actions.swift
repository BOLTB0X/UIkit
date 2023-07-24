//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/24.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        // Objective-C API를 사용하여 메소드를 사용자 지정 버튼에 연결
        guard let id = sender.id else { return }
        completeReminder(withId: id)

        
    }
}
