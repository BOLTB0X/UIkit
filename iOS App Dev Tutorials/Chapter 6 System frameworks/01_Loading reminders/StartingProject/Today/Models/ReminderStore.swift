//
//  ReminderStore.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/09.
//

import EventKit
import Foundation

final class ReminderStore {
    static let shared = ReminderStore() // shared라는 정적 프로퍼티 만들고 새 ReminderStore에 할당
    
    private let ekStore = EKEventStore() // ekStore라는 private 프로퍼티를 만들고 새 EKEventStore를 할당
    
    var isAvailable: Bool { // 미리 알림 권한 부여 상태가 .authorized인 경우 true를 반환하는 isAvailable이라는 계산된 프로퍼티
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    // MARK: - requestAccess
    func requestAccess() async throws {
        // 미리 알림 인증 상태를 저장하는 상수를 만듬
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        switch status {
        case .authorized: // 사용자가 미리 알림 데이터에 대한 액세스 권한을 부여한 경우 호출 함수로 실행을 되돌림
            return
        case .restricted: // 시스템에서 미리 알림 데이터에 대한 액세스를 제한하는 경우 오류가 발생
            throw TodayError.accessRestricted
            
        case .notDetermined: // 사용자가 아직 결정을 내리지 않은 경우 사용자 데이터에 대한 액세스를 요청
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {
                throw TodayError.accessDenied
            }
            
        case .denied: // 사용자가 미리 알림 데이터에 대한 액세스를 허용하지 않기로 결정한 경우 오류가 발생
            throw TodayError.accessDenied
            
        // 기본 경우에 오류를 발생, 기본 키워드 앞에 @unknown 속성이 없어도 앱이 작동
        // 그러나 특성을 추가하면 API의 향후 버전이 열거형에 새 사례를 추가하는 경우 경고하도록 컴파일러에 지시
        @unknown default:
            throw TodayError.unknown
        }

    }
    
    // MARK: - readAll
    // Reminder의 배열을 반환하는 readAll이라는 async throws 함수
    func readAll() async throws -> [Reminder] {
        guard isAvailable else { // 미리 알림 액세스를 사용할 수 없는 경우 오류를 발생시키는 가드 문을 추가
            throw TodayError.accessDenied
        }
        
        // 서술어라는 상수를 만들고 저장소의 predicateForReminders에 할당
        let predicate = ekStore.predicateForReminders(in: nil)
        // 미리 알림(일치:)의 결과를 기다리는 ekReminders라는 상수
        // await 키워드는 작업이 재개되고 결과를 ekReminders 상수에 할당하는 시점에 결과가 제공될 때까지 작업이 일시 중단됨을 나타냄
        let ekReminders = try await ekStore.reminders(matching: predicate)
        
        // [EKReminder]에서 [Reminder]로 데이터를 매핑한 결과를 저장하는 알림이라는 상수를 만듬
        // compactMap(_:)은 필터와 맵으로 작동하여 소스 컬렉션에서 항목을 삭제 가능
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
            do { // 변환된 미리 알림을 반환하는 클로저에 do 블록을 추가
                return try Reminder(with: ekReminder)
            } catch TodayError.reminderHasNoDueDate { // 미리 알림에 기한이 없는 경우 nil을 반환하는 catch 블록을 추가
                return nil
            }
        }
        return reminders
    }
}
