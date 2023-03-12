/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

// Identifiable protocol 선언
// 식별 가능한 형식에는 id 속성이 있어야 하므로 컴파일러에서 오류가 발생
struct Reminder : Identifiable {
    // 기본값이 UUID().uuidString인 id라는 String 속성을 추가
    // Foundation의 UUID 구조는 보편적으로 고유한 값을 생성
    var id: String = UUID().uuidString
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}

// 추가
// 또한 where 절을 사용하여 Array where Element == Reminder 확장과 같이 일반 유형을 조건부로 확장 가능
extension [Reminder] {
    // id 인수를 수락하고 Self.Index를 반환하는 indexOfReminder라는 함수
    // Array.Index는 Int의 유형 별칭
    func indexOfReminder(withId id: Reminder.ID) -> Self.Index {
        // 식별자와 일치하는 요소의 첫 번째 인덱스를 index라는 상수에 할당
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        // 매칭한 인덱스 반환
        return index
    }
}

#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(
            title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0),
            notes: "Don't forget about taxi receipts"),
        Reminder(
            title: "Code review", dueDate: Date().addingTimeInterval(14000.0),
            notes: "Check tech specs in shared folder", isComplete: true),
        Reminder(
            title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0),
            notes: "Optometrist closes at 6:00PM"),
        Reminder(
            title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0),
            notes: "Collaborate with project manager", isComplete: true),
        Reminder(
            title: "Interview new project manager candidate",
            dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio"),
        Reminder(
            title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0),
            notes: "Think different"),
        Reminder(
            title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0),
            notes: "Discuss trends with management"),
        Reminder(
            title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0),
            notes: "Ask about space heaters"),
        Reminder(
            title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),
            notes: "v0.9 out on Friday")
    ]
}
#endif
