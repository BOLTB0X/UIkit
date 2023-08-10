//
//  EKReminder+Reminder.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/10.
//

import EventKit
import Foundation

extension EKReminder {
    // MARK: - update
    // Reminder와 EKEventStore를 받는 update(using:in:) 함수를 생성
    func update(using reminder: Reminder, in store: EKEventStore) {
        title = reminder.title
        notes = reminder.notes
        isCompleted = reminder.isComplete
        // defaultCalendarForNewReminders()를 calendar 속성에 할당
        calendar = store.defaultCalendarForNewReminders()
        
        // 알람을 반복하면서 미리 알림의 기한과 일치하지 않는 알람을 제거
        // 비교는 동일한 분 동안 발생하는 경우 날짜가 동일한 것으로 결정
        alarms?.forEach { alarm in
            guard let absoluteDate = alarm.absoluteDate else { return }
            let comparison = Locale.current.calendar.compare(
                reminder.dueDate, to: absoluteDate, toGranularity: .minute)
            if comparison != .orderedSame {
                removeAlarm(alarm)
            }
        }
        
        if !hasAlarms {
            addAlarm(EKAlarm(absoluteDate: reminder.dueDate))
        }
    }
}
