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
    
    // MARK: IBOutlets
    // IBOutlet 프로퍼티 추가
    // 인터페이스 빌더와 인스턴스 연결
    // 프로퍼티를 여기서 수정해 버리면 인터페이스 빌더가 인식을 못함
    // 그러므로 다시 연결해야함
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    
    // MARK: - Methods
    // MARK: Custom Method
    // player 초기화
    func initializePlayer() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원 파일 에셋을 가져올 수 없음")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
    
    // MARK: - Methods
    // MARK: Custom Method
    // 레이블을 초단위로 업데이트
    // timer 업데이트
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        
        self.timeLabel.text = timeText
    }
    
    // MARK: - Methods
    // MARK: Custom Method
    // 타이머 생성 및 수행
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
          
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    // MARK: - Methods
    // MARK: Custom Method
    // 타이머 해제
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
//    func addViewsWithCode() {
//        self.addPlayPauseButton()
//        self.addTimeLabel()
//        self.addProgressSlider()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer() // 추가
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*          인터페이스 빌더 메소트            */
    // MARK: IBActions
    
    // 버튼을 눌렀을 때
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        // modify
        sender.isSelected = !sender.isSelected
        
        // 선택 되었다면
        if sender.isSelected {
            self.player?.play() // 플레인 경우
        } else {
            self.player?.pause() // 중지인 경우
        }
        
        if sender.isSelected { // 타이머 관련이라면
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
        }
    }
    
    // 슬라이드가 변경 되었을 때
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking{ return }
        self.player.currentTime = TimeInterval(sender.value)
    }
    

}
