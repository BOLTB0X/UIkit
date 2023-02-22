//
//  ViewController.swift
//  Today
//
//  Created by KyungHeon Lee on 2023/02/22.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    // 뷰 컨트롤러가 뷰 계층 구조를 메모리에 로드한 후 시스템은 viewDidLoad()를 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        // 컬렉션 보기 레이아웃에 목록 레이아웃을 할당
        collectionView.collectionViewLayout = listLayout
        // Do any additional setup after loading the view.
    }
    
    // 일단 return 값이 안되어 추가가 필요
    // 구분 기호를 비활성화하고 배경색을 지우도록 변경
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // 목록 구성으로 새로운 컴포지션 레이아웃 반환
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

