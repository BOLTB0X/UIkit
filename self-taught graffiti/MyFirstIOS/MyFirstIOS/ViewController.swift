//
//  ViewController.swift
//  MyFirstIOS
//
//  Created by KyungHeon Lee on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    
    // 제목
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Swift!!!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //  정가운데
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
