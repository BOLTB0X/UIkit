//
//  Reminder+EKReminder.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/09.
//

import EventKit
import Foundation

extension Reminder {
    // EKReminder를 허용하는 throws 초기화 생성
    init(with ekReminder: EKReminder) throws {
        // 미리 알림의 첫 번째 알람의 절대 날짜를 바인딩하는 보호 문을 추가, else 절에서 오류를 발생시킵
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
            throw TodayError.reminderHasNoDueDate
        }
        // id 속성에 달력 식별자를 할당
        // EventKit은 모든 미리 알림에 대한 고유 식별자를 제공
        id = ekReminder.calendarItemIdentifier
        
        // 제목, dueDate, 메모 및 isComplete 프로퍼티를 할당
        title = ekReminder.title
        self.dueDate = dueDate
        notes = ekReminder.notes
        isComplete = ekReminder.isCompleted
    }
}
