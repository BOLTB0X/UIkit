//
//  UIView+PinnedSubview.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

extension UIView {
    // MARK: - addPinnedSubview
    // 하위 view, 높이 및 삽입을 허용하는 새 addPinnedSubview(_:height:insets:) 함수
    func addPinnedSubview(
        _ subview: UIView, height: CGFloat? = nil,
        insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    ) {
        // UIView의 addsubview(_:) 메서드는 하위 뷰를 상위 뷰 계층 구조의 맨 아래에 추가
        addSubview(subview)
        // translatesAutoresizingMaskIntoConstraints를 비활성화하여 시스템이 이 보기에 대한 자동 제약 조건을 만들지 않도록 함
        // 모든 크기 또는 방향에 대해 뷰를 동적으로 배치하는 제약 조건을 제공
        subview.translatesAutoresizingMaskIntoConstraints = false
        // 상단 앵커 제약 조건을 추가하고 활성화하여 하위 뷰를 상위 뷰 상단에 고정
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        /// 선행 앵커 제약 조건을 지정하고 활성화하여 하위 보기의 선행 가장자리에 패딩을 추가
        /// 자동 레이아웃은 왼쪽과 오른쪽 대신 리딩과 트레일링을 사용하여 수평축을 따라 뷰의 이웃을 결정
        /// 이 접근 방식을 통해 자동 레이아웃은 오른쪽에서 왼쪽 및 왼쪽에서 오른쪽 언어로 보기의 모양을 자동으로 수정
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        // 후행 앵커 제약 조건을 지정하고 활성화하여 하위 보기의 후행 가장자리에 패딩을 추가
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right)
            .isActive = true
        // 아래쪽 앵커 제약 조건을 정의하고 활성화하여 하위 보기의 아래쪽에 패딩을 추가
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom)
                    .isActive = true
        // 호출자가 명시적으로 함수에 높이를 제공하는 경우 하위 뷰를 해당 높이로 제한
        // 하위 뷰는 상위 뷰의 상단과 하단에 고정되어 있기 때문에 하위 뷰의 높이를 조정하면 상위 뷰도 높이를 조정해야 함
        if let height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
