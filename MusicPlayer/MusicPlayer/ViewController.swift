//
//  ViewController.swift
//  MusicPlayer
//
//  Created by KyungHeon Lee on 2023/02/06.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlet 프로퍼티 추가
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

