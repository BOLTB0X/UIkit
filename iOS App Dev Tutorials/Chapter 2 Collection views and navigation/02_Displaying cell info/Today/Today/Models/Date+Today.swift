//
//  Date+Today.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/25.
//

import Foundation

extension Date {
    var dayAndTimeText: String {
        // formatted(date:time:) 메서드를 호출하여 시간의 문자열 표현을 만들고 그 결과를 timeText라는 상수에 할당
        // 시스템은 기본 스타일을 사용하여 현재 로케일에 대한 날짜 및 시간의 문자열 표현 형식을 지정
        // 날짜 스타일에 .omitted를 전달하면 시간 구성 요소만 포함된 문자열이 생성
        let timeText = formatted(date: .omitted, time: .shortened)
        
        // 이 날짜가 현재 날짜인지 여부를 체크
        if Locale.current.calendar.isDateInToday(self) {
            // NSLocalizedString(_:comment:) 함수를 호출하여 형식화된 시간 문자열을 만들고 그 결과를 timeFormat이라는 상수에 할당
            // comment 매개변수는 번역자에게 현지화된 문자열이 사용자에게 어떻게 표시되는지에 대한 컨텍스트를 제공
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            
            // 시간 텍스트에 timeFormat을 적용하여 문자열을 만들고 결과를 반환
            return String(format: timeFormat, timeText)
        } else {
            // 다음으로 제공된 날짜가 현재 달력 날짜가 아닌 경우 Foundation 프레임워크의 formatted(date:time:)을 사용하여 형식이 지정된 문자열을 만듭
            
            // formatted(_:) 메서드를 호출하여 날짜의 문자열 표현을 만들고 그 결과를 dateText라는 상수에 할당
            // formatted(_:) 메서드는 사용자 지정 날짜 형식 스타일을 사용하여 사용자의 현재 로케일에 적합한 날짜 표현을 만들어 줌
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            // NSLocalizedString(_:comment:) 함수를 호출하여 날짜와 시간을 표시하기 위한 형식화된 문자열을 만들고 그 결과를 dateAndTimeFormat이라는 상수에 할당
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            // 날짜 및 시간 텍스트에 dateAndTimeFormat을 적용하여 문자열을 만들고 결과를 반환
            return String(format: dateAndTimeFormat, dateText, timeText)
            // 계산된 속성은 이제 로케일 인식 형식으로 날짜와 시간을 나타낼 거임
        }
    }
    
    // 날짜만 형식화되고 지역화된 문자열 표현을 반환하는 dayText라는 또 다른 계산된 속성
    // 그런 다음 아래 단계에서 사용자 지정 날짜 형식을 포함하는 솔루션을 참조
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            // 이 날짜가 현재 날짜가 아닌 경우 formatted(_:) 메서드를 호출하여 날짜의 문자열 표현을 만들고 결과를 반환
            // 이 형식화된 메서드는 월, 일 및 요일만 포함하는 사용자 지정 날짜 스타일을 허용
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
