//
//  ViewController.swift
//  LoadRemoteimageUrl
//
//  Created by KyungHeon Lee on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    
    var imgOn1: UIImage?
    var imgOff1: UIImage?
    var isClick1: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")
        img1.load(url: url!)
    }

    @IBAction func btn1Click(_ sender: Any) {
        if (isClick1) {
            img1.image = imgOn1
        } else {
            img1.image = imgOff1
        }
        
        isClick1 = !isClick1
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
