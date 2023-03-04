//
//  ViewController.swift
//  practiceButton
//
//  Created by KyungHeon Lee on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {
        
    // 카운트 변수
    var cnt: Int = 0
    
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var btnP: UIButton!
    
    @IBOutlet weak var btnN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 방법 1
        textLabel.text = "\(textLabel)"
        
        // 레이벨 방법 2
        textLabel.text = String(format: "%d", cnt)
        
        btnP.addTarget(self, action: #selector(addAct(_:)), for: .touchUpInside)
        
        btnN.addTarget(self, action: #selector(subAct(_:)), for: .touchUpInside)
    }

    @IBAction func addAct(_ sender: Any) {
        // 버튼이 눌렸을 경우
        cnt += 1
        textLabel.text = "\(cnt)"
    }
    
    @IBAction func subAct(_ sender: Any) {
        // 버튼이 눌렸을 경우
        cnt -= 1
        textLabel.text = "\(cnt)"
    }
}

