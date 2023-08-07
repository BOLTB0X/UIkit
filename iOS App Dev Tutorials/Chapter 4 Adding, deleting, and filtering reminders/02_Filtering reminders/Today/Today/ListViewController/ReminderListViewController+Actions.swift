//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/07/24.
//

import UIKit

extension ReminderListViewController {
    // MARK: - didPressDoneButton
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        // Objective-C API를 사용하여 메소드를 사용자 지정 버튼에 연결
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
    // MARK: - didPressAddButton
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let reminder = Reminder(title: "", dueDate: Date.now)
        // 빈 완료 핸들러가 있는 ReminderViewController 인스턴스를 만듬
        // 리마인더 뷰 컨트롤러가 리마인더 목록 뷰 컨트롤러에 대한 강력한 참조를 캡처하고 저장하지 못하도록 클로저의 캡처 목록에 [weak self]를 추가함
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            // didPressAddButton의 빈 클로저에서 addReminder를 호출
            self?.addReminder(reminder)
            self?.updateSnapshot() // 스냅샷을 업데이트
            // 목록 view 만들기에서 앱의 데이터가 변경될 때마다 사용자 인터페이스를 업데이트하기 위해 스냅샷을 만들고 적용해야 했던 것을 기억 가능
            
            self?.dismiss(animated: true)
        }
        
        // 뷰 컨트롤러의 isAddingNewReminder 속성을 true로 설정
        viewController.isAddingNewReminder = true
        viewController.setEditing(true, animated: false)
        // didCancelAdd 작업을 호출하는 막대 버튼 .cancel 항목을 만들고 내비게이션 항목의 leftBarButtonItem에 버튼을 할당
        // 메소드를 @objc 속성으로 표시했기 때문에 didCancelAdd를 선택기로 지정할 수 있음
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString(
                    "Add Reminder", comment: "Add Reminder view controller title")
        
        // 알림 보기 컨트롤러를 루트로 사용하여 탐색 컨트롤러
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    // MARK: - didCancelAdd
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
