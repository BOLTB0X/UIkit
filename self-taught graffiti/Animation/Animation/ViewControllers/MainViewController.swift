//
//  ViewController.swift
//  Animation
//
//  Created by KyungHeon Lee on 2023/01/05.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
         label.textColor = .black // label 색
         label.textAlignment = .center // label 위치
         label.text = "메인 화면"
         label.font = UIFont.boldSystemFont(ofSize: 70)
        
        return label
    } ()
    
    let animationView: LottieAnimationView = {
        
        let animView = LottieAnimationView(name: "132124-hands-typing-on-keyboard")
        // 크기를 정해줌
        animView.frame = CGRect(x:0, y:0, width: 400, height: 400)
        
        // 크기에 맞게 맞춰줌
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    
    // 뷰가 생성되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 화면 검게
        view.backgroundColor = .black
        view.addSubview(animationView)
        animationView.center = view.center
        
        // 애니메이션 실행
        animationView.play{ (finish) in
            print("애니메이션 끝")
            
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview()
            
            self.view.addSubview(self.titleLabel)
            
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false // 이게 없으면 적용이 안됌
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
}

