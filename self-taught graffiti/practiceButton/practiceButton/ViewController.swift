//
//  ViewController.swift
//  practiceButton
//
//  Created by KyungHeon Lee on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var check:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickButton(_ sender: Any) {
        print("push")
        check.toggle()
    }
    
}

