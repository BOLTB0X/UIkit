/*
 See LICENSE folder for this sample’s licensing information.
 */

import EventKit
import Foundation

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return
        case .restricted:
            throw TodayError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {
                throw TodayError.accessDenied
            }
        case .denied:
            throw TodayError.accessDenied
        @unknown default:
            throw TodayError.unknown
        }
    }
    
    func readAll() async throws -> [Reminder] {
        guard isAvailable else {
            throw TodayError.accessDenied
        }
        
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await ekStore.reminders(matching: predicate)
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
            do {
                return try Reminder(with: ekReminder)
            } catch TodayError.reminderHasNoDueDate {
                return nil
            }
        }
        return reminders
    }
    
    // MARK: - save
    /// 모든 상황에서 이 메서드가 반환하는 식별자를 사용 X
    /// @discardableResult 특성은 호출 사이트가 반환 값을 캡처하지 않는 경우 경고를 생략하도록 컴파일러에 지시
    @discardableResult
    func save(_ reminder: Reminder) throws -> Reminder.ID {
        guard isAvailable else {
            throw TodayError.accessDenied
        }
        let ekReminder: EKReminder
        do { // read(with:)를 호출하고 결과를 상수에 할당하는 do 블록을 추가
            ekReminder = try read(with: reminder.id)
        } catch { // 이벤트 저장소에 새 미리 알림을 만들고 이를 상수에 할당하는 catch 블록을 추가
            ekReminder = EKReminder(eventStore: ekStore)
        }
        
        // 수신 미리 알림의 값을 사용하여 ekReminder를 업데이트함
        ekReminder.update(using: reminder, in: ekStore)
        try ekStore.save(ekReminder, commit: true)
        return ekReminder.calendarItemIdentifier
    }
    
    func remove(with id: Reminder.ID) throws {
        guard isAvailable else {
            throw TodayError.accessDenied
        }
        
        // 해당 식별자로 미리 알림 읽기
        let ekReminder = try read(with: id)
        try ekStore.remove(ekReminder, commit: true)
    }
    
    // MARK: - read
    // 리마인더 식별자를 받아들이고 EKReminder를 반환하는 read(with:)라는 이름의 프라이빗 던지기 함수를 생성
    private func read(with id: Reminder.ID) throws -> EKReminder {
        // 일치하는 일정 항목을 검색하고 EKReminder로 캐스팅하는 보호 문을 추가
        // calendarItem(withIdentifier:) 메서드는 슈퍼클래스 EKCalendarItem을 반환하므로 EKReminder로 다운캐스트
        // 다운캐스트는 항목을 EKReminder로 안전하게 취급할 수 있음
        guard let ekReminder = ekStore.calendarItem(withIdentifier: id) as? EKReminder else {
            throw TodayError.failedReadingCalendarItem
        }
        return ekReminder
    }
}
