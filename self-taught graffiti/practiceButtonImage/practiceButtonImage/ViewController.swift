//
//  ViewController.swift
//  practiceButtonImage
//
//  Created by KyungHeon Lee on 2023/03/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateBtn: UIButton!
    
    var imgOn: UIImage?
    var imgOff: UIImage?
    var isClick: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOff = UIImage(named: "imgIronman")
        imgOn = UIImage(named: "imgBlank.png")
        
        stateImage.image = imgOn
    }

    @IBAction func swichBtn(_ sender: UIButton) {
        if (isClick) {
            stateImage.image = imgOn
        } else {
            stateImage.image = imgOff
        }
        
        isClick = !isClick
    }
    
}

