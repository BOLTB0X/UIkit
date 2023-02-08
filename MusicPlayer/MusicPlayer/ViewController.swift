//
//  ViewController.swift
//  MusicPlayer
//
//  Created by KyungHeon Lee on 2023/02/06.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    // 추가
    var player: AVAudioPlayer!
    var timer: Timer!
    
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
    
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        print("button tapped")
    }
    
    @IBAction func sliderValuechanged(_ sender: UISlider) {
        print("slider Value changed")
    }
    
}

