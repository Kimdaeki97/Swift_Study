//
//  ViewController.swift
//  Audio
//
//  Created by 김대기 on 2021/01/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    
    let MAX_VOLUME : Float = 10.0
    
    var progressTimer : Timer!
    
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode {  // 재생 모드일 때
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {            // 녹음 모드일 떄
            initRecord()
        }
    }
    
    // 재생 모드와 녹음 모드에 따라 다른 파일을 선택함
    func selectAudioFile() {
        if !isRecordMode {
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // 녹음 모드의 초기화
    func initRecord() {
        let recordSettings = [
            AVFormatIDKey : NSNumber(value : kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitDepthHintKey : 320000,
            AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do{
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setAvtive : \(error)")
        }
    }
    
    // 재생 모드의 초기화
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // 재생, 일시정지, 정지 버튼을 활성화 또는 비활성화하는 함수
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 00:00 형태의 문자열로 변환함
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTIme = String(format: "%02d:%02d", min, sec)
        return strTIme
    }
    
    // 재생 버튼을 클릭하였을 때
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    // 0.1초마다 호출되며 재생 시간을 표시함
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    // 일시 정지 버튼을 클릭하였을 때
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    // 정지 버튼을 클릭하였을 때
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    
    // 볼륨 슬라이더 값을 audioplayer.volume에 대입함
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // 재생이 종료되었을 때 호출됨
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // 스위치를 On/Off 하여 녹음 모드인지 재생 모드인지를 결정함
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {   // 녹음 모드일 때
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {          // 재생 모드일 때
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile()      // 모드에 따라 오디오 파일을 선택함
        // 모드에 따라 재생 초기화 또는 녹음 초기화를 수행함
        if !isRecordMode {     // 녹음 모드가 아닐 때, 즉 재생 모드일 때
            initPlay()
        } else {               // 녹음 모드일 때
            initRecord()
        }
    }
    
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            // 버튼이 "Record"일 때 녹음을 중지함
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {   // 버튼이 "Stop"일 때 녹음을 위한 초기화를 수행함
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    // 0.1초마다 호출되며 녹음 시간을 표시함
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
    
}

