//
//  CAGradientLayer+ListStyle.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/08.
//

import UIKit
/// UIKit에는 색상 그라데이션을 나타내는 CAGradientLayer 클래스가 포함되어 있음
/// 배열에 원하는 수의 색상을 제공하여 그라데이션을 만들고 기본적으로 시스템은 레이어 전체에 균일하게 색상을 그리지만 그라데이션 중지점의 특정 위치를 정의할 수 있음

extension CAGradientLayer {
    // MARK: - gradientLayer
    // 스타일 및 프레임에 대한 매개변수를 수락하고 CAGradientLayer를 반환하는 gradientLayer(for:in:)라는 정적 함수
    // CAGradientLayer의 확장에서 함수를 선언하기 때문에 반환 유형의 대문자 Self는 CAGradientLayer 유형을 참조합
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self() // 새 레이어 상수를 추가하고 새 CAGradientLayer를 할당
        layer.colors = colors(for: style) // colors(for:) 함수의 결과를 레이어의 colors 속성에 할당
        
        layer.frame = frame // 프레임을 레이어의 프레임 속성에 할당
        return layer
    }
    
    // MARK: - colors
    // 목록 스타일을 받아들이고 CGColor의 배열을 반환하는 colors(for:)라는 비공개 정적 함수
    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        // UIColor 유형의 beginColor 및 endColor라는 상수를 만듬
        // 이러한 상수는 그라데이션 중지점의 시작 및 끝 색상을 정의
        let beginColor: UIColor
        let endColor: UIColor
        
        /// 스타일 매개변수를 전환하고 분할된 컨트롤의 각 필터(Today, Future 및 All)에 대해 시작 및 종료 색상을 지정하는 사례를 만듬
        /// 각 필터에 다른 그라데이션 배경을 할당하면 각 보기가 다른 미리 알림을 로드한다는 시각적 신호가 생성
        switch style {
        case .all:
            beginColor = .todayGradientAllBegin
            endColor = .todayGradientAllEnd
        case .future:
            beginColor = .todayGradientFutureBegin
            endColor = .todayGradientFutureEnd
        case .today:
            beginColor = .todayGradientTodayBegin
            endColor = .todayGradientTodayEnd
        }
        
        // 시작과 끝 CGColor 객체를 포함하는 배열을 반환
        return [beginColor.cgColor, endColor.cgColor]
    }
}
