//
//  EKEventStore+AsyncFetch.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/09.
//

import EventKit
import Foundation

// EKEventStore 개체는 사용자의 일정 이벤트 및 미리 알림에 액세스 가능
extension EKEventStore {
    // MARK: - reminders
    // 서술어를 수락하고 EKReminder의 배열을 반환
    // 함수 매개변수 뒤의 async 키워드는 이 함수가 비동기적으로 실행될 수 있음을 나타냄
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        // 일반 withCheckedThrowingContinuation(_:) Swift 함수를 호출
        // await 키워드는 작업이 계속될 때까지 일시 중단됨을 나타냄
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in // EventKit 메서드 fetchReminders(matching:)를 호출하여 메서드는 일치하는 미리 알림을 완료 처리기에 전달
                if let reminders { // 미리 알림을 로컬 상수에 바인딩하는 if-let 조건문을 작성
                    continuation.resume(returning: reminders) // 성공하면 계속을 재개하고 미리 알림을 반환하고 함수가 실행을 재개하고 EKReminder 배열을 반환
                } else {
                    // 실패하면 계속 진행하여 오류를 발생시킴
                    continuation.resume(throwing: TodayError.failedReadingReminders)
                }
            }
        }
    }
}
