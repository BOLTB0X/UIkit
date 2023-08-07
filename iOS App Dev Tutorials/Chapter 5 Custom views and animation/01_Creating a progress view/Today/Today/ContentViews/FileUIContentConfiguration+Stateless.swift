//
//  FileUIContentConfiguration+Stateless.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/01.
//

import UIKit

extension UIContentConfiguration {
    // MARK: - updated
    // self를 반환하는 updated(for:) 메소드
    /// updated(for:) 메소드를 사용하면 UIContentConfiguration이 주어진 상태에 대한 특수 구성을 제공
    /// Today에서는 일반, 강조 표시 및 선택을 포함한 모든 상태에 대해 동일한 구성을 사용
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
