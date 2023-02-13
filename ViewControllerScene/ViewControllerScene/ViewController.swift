//
//  ViewController.swift
//  ViewControllerScene
//
//  Created by KyungHeon Lee on 2023/02/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 서브뷰 생성
        let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
        let subView = UIView(frame: frame)
        
        // 서브뷰의 색상
        subView.backgroundColor = UIColor.green
        
        // 서브뷰 추가하기
        view.addSubview(subView)
        
        // 서브뷰 제거하기
        subView.removeFromSuperview()
        
        print("프레임의 CGRect : \(subView.frame)")
        print("바운드의 CGRect : \(subView.bounds)")
        print("프레임의 CGRect : \(subView.frame.origin)")
        print("바운드의 CGRect : \(subView.bounds.origin)")
        
        self.view.addSubview(subView)
    }
}

