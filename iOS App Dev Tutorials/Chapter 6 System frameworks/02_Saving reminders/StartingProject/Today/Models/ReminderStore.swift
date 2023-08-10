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
