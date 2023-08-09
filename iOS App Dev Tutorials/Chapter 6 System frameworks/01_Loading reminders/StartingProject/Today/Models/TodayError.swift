//
//  TodayError.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/09.
//

import Foundation

// MARK: - TodayError
// LocalizedError를 준수하는 유형은 오류와 발생 이유를 설명하는 지역화된 메시지를 제공
enum TodayError: LocalizedError {
    case accessDenied
    case failedReadingReminders // failedReadingReminders라는 case를 추가
    case reminderHasNoDueDate // 사례와 해당 설명
    
    var errorDescription: String? { // 오류를 설명하는 errorDescription 프로퍼티를 추가
        switch self { // LocalizedError는 기본 구현을 제공하므로 이 프로퍼티를 구현할 필요 X
        case .accessDenied:
            return NSLocalizedString(
                "The app doesn't have permission to read reminders.",
                comment: "access denied error description")
            
        case .failedReadingReminders: // 사용자는 오류가 발생하는 이유에 대한 명확한 정보를 얻을 수 있음
            return NSLocalizedString(
                "Failed to read reminders.", comment: "failed reading reminders error description")
        
        case .reminderHasNoDueDate:
                    return NSLocalizedString(
                        "A reminder has no due date.", comment: "reminder has no due date error description")
        }
    }
}
