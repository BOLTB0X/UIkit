//
//  ReminderListStyle.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/07.
//

import Foundation

enum ReminderListStyle: Int {
    case today
    case future
    case all
    
    // MARK: - shouldInclude
    // Date 매개변수를 수락하고 Bool 값을 반환하는 shouldInclude 함수
    // ReminderListViewController는 사용자가 선택한 목록 스타일과 일치하는 기한이 있는 미리 알림만 표시
    func shouldInclude(date: Date) -> Bool {
        // sInToday의 값은 호출자가 함수에 전달한 날짜가 오늘이면 true이고 그렇지 않으면 false
        // Locale.current.calendar는 사용자의 지역 설정을 기반으로 하는 현재 달력
        let isInToday = Locale.current.calendar.isDateInToday(date)
        
        // self를 전환하고 각 스타일에 지정된 날짜가 포함되는지 여부를 나타내는 부울 값을 반환
        switch self {
        case .today:
            return isInToday
        case .future:
            return (date > Date.now) && !isInToday
        case .all:
            return true
        }
    }
}
