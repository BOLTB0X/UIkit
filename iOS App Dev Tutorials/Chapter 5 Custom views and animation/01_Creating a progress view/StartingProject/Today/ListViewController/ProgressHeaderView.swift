//
//  ProgressHeaderView.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/08/08.
//

import UIKit

/// 사용자가 보이는 범위 밖으로 스크롤할 때 view를 삭제하는 대신 UICollectionReusableView 클래스는 재사용 대기열에 보기를 유지
/// UICollectionReusableView를 사용하여 보충 보기를 만들 기 가능
/// 보충 보기는 개별 컬렉션 view 셀과 분리되어 있으므로 머리글 또는 바닥글을 만드는 데 이상적
class ProgressHeaderView: UICollectionReusableView {
    // elementKind라는 정적 프로퍼티를 추가
    // 요소 종류는 컬렉션 view가 표시할 수 있는 보충 view의 유형을 지정
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    //var progress: CGFloat = 0 // 기본값이 0인 CGFloat 유형의 progress
    // 진행률 값이 변경될 때 하단 뷰의 높이 제한을 업데이트하는 진행률 속성에 관찰자를 추가
    var progress: CGFloat = 0 {
        didSet {
            // 진행을 위한 didSet 관찰자에서 setNeedsLayout()을 호출함
            // setNeedsLayout()을 호출하면 현재 레이아웃이 무효화되고 업데이트가 트리거됨
            setNeedsLayout()
            /// 애니메이션 블록을 생성하기 위해 animate(withDuration:animations:)를 호출하여 보기에 대한 변경 사항을 애니메이션화
            /// 다음 뷰 애니메이션 클로저에서 layoutIfNeeded()를 호출
            heightConstraint?.constant = progress * bounds.height
            /// layoutIfNeeded() 메서드는 위쪽 및 아래쪽 뷰의 높이 변경에 애니메이션을 적용하여 뷰가 레이아웃을 즉시 업데이트
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    /// private 프로퍼티를 추가하여 upperView, lowerView 및 containerView 하위 view 생성
    /// 크기가 0인 프레임으로 각 프로퍼티를 초기화
    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    
    private var heightConstraint: NSLayoutConstraint? // add
    
    // 완료율을 읽기 위해 지역화된 형식 문자열과 함께 valueFormat이라는 프로퍼티를 추가
    private var valueFormat: String {
        NSLocalizedString("%d percent", comment: "progress percentage value format")
    }
    
    // 일부 사용자 지정 초기화를 수행하고 super.init를 호출할 수 있도록 지정된 초기화 프로그램을 재정의
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        
        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("Progress", comment: "Progress view accessibility label")
        accessibilityTraits.update(with: .updatesFrequently)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layoutSubviews
    // layoutSubviews()를 재정의하고 슈퍼뷰의 구현을 호출
    override func layoutSubviews() {
        super.layoutSubviews()
        // layoutSubviews()에서 progress 값과 값 포맷터를 사용하여 AccessibilityValue에 새 문자열을 할당
        accessibilityValue = String(format: valueFormat, Int(progress * 100.0))
        
        // layoutSubviews()에서 높이 제약 조건의 상수를 업데이트
        heightConstraint?.constant = progress * bounds.height
        
        /// 컨테이너 보기의 레이어에서 masksToBounds를 활성화하고 모서리 반경을 조정
        /// Core Animation은 컨테이너 뷰를 원형으로 만드는 CGRect 프레임에 클리핑 마스크를 적용
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 0.5 * containerView.bounds.width
    }

    
    // MARK: - prepareSubviews
    /// 뷰 계층 구조에 하위 뷰를 추가하기 위해 prepareSubviews라는 함수를 생성
    /// containerView의 하위 뷰로 upperView 및 lowerView를 추가
    /// 진행률 헤더 보기의 하위 보기로 containerView를 추가
    private func prepareSubviews() {
        containerView.addSubview(upperView)
        containerView.addSubview(lowerView)
        addSubview(containerView)
        
        // 하위 view에 대한 제약 조건을 수정할 수 있도록 하위 view에 대한 translatesAutoresizingMaskIntoConstraints를 비활성화
        // true인 경우 시스템에서 뷰의 크기와 위치를 자동으로 지정
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        /// 슈퍼뷰와 컨테이너 뷰에 대해 1:1 고정 영상비를 유지
        /// isActive에 true를 할당하면 뷰 계층 구조의 공통 조상에 제약 조건이 추가되고 이를 활성화하는 콘텐츠 뷰를 사용
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1)
            .isActive = true
        
        // 레이아웃 프레임에서 컨테이너 뷰를 수평 및 수직 중앙에 배치
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        // 진행률 헤더 보기 크기의 85%로 컨테이너 보기를 확장
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        
        /// 다음을 설정하여 하위 view를 세로로 설정
        /// upperView 상단 앵커를 진행률 헤더 뷰의 상단 앵커로, upperView 하단 앵커를 lowerView 상단 앵커로, lowerView 하단 앵커를 진행률 헤더의 뷰 하단 앵커로 설정
        upperView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
        lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // 진행률 헤더 보기와 동일하게 upperView 및 lowerView 선행 및 후행 앵커를 설정하여 하위 View를 수평으로 제한
        upperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        upperView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lowerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lowerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        /// 아래쪽 뷰에 대해 조정 가능한 높이 제약 조건을 만들고 높이 앵커에 시작 크기 0을 할당
        /// 이 제약 조건은 미리 알림을 완료하는 사용자의 진행 상황을 반영하기 위해 하단 보기의 높이를 늘림
        /// 이 제약 조건이 증가하면 높이가 반비례하기 때문에 위쪽 뷰의 높이가 줄어듭
        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
                heightConstraint?.isActive = true
        
        /// 뷰에 배경색을 지정
        /// 시작 프로젝트의 자산 카탈로그에는 상단 및 하단 보기의 배경에 대한 색상 값이 포함되어 있음
        /// 시각적 장식이 필요하지 않으므로 컨테이너 보기 배경을 지우도록 설정해야 함
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        upperView.backgroundColor = .todayProgressUpperBackground
        lowerView.backgroundColor = .todayProgressLowerBackground
    }
}
