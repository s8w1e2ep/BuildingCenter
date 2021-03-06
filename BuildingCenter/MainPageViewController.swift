//
//  MainPageViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 08/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class MainPageViewController: UIViewController {

    // main page button
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var hipsterButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    
    // for change text size
    @IBOutlet weak var slider: UISlider!
    
    // view for display main content
    @IBOutlet weak var mainContainerView: UIView!
    
    // NavigationViewController contains zones, modes, devices, companies infomation.
    var mapNavigationController: UINavigationController!
    // ViewController for hipster selecting or taking a picture to do some thing.
    var hipsterViewController: HipsterViewController!

    // Record the ViewController and button selected.
    var selectedViewController: UIViewController!
    var selectedButton: UIButton!
    
    // For text speak
    var TTS: String!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    // Notification
    let notificationExitMap = Notification.Name("exitMapNoti")
    
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationEnterModeContent = Notification.Name("enterModeContentNoti")
    let notificationExitModeContent = Notification.Name("exitModeContentNoti")
    let notificationPageChanged = Notification.Name("pageChangededNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    let notificationFirmClicked = Notification.Name("firmClickedNoti")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getViewController()
        setInitSelected()
        setNotification()
        setTTS()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainMenu(_ sender: UIStoryboardSegue) {
        
    }
    @IBAction func onMapClick(_ sender: UIButton) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        if !mapButton.isSelected {
            changeTab(to: mapButton)
            changePage(to: mapNavigationController)
            
        }
        // Back to SVG map
        mapNavigationController.popToRootViewController(animated: true)
    }
    
    @IBAction func onInfoClick(_ sender: UIButton) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        if infoButton.isSelected {
            
            infoButton.isSelected = false
            NotificationCenter.default.post(name: notificationFirmClicked, object: nil, userInfo: ["isAdded":1])
        }
        else {
            changeTab(to: infoButton)
            NotificationCenter.default.post(name: notificationFirmClicked, object: nil, userInfo: ["isAdded":0])
        }
    }
    
    @IBAction func onHipsterClick(_ sender: UIButton) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        changeTab(to: hipsterButton)
        changePage(to: hipsterViewController)
    }
    @IBAction func onSpeechClick(_ sender: UIButton) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        if speechButton.isSelected {
            synth.stopSpeaking(at: AVSpeechBoundary.immediate)
            speechButton.isSelected = false
        }else {
            changeTab(to: speechButton)
            myUtterance = AVSpeechUtterance(string: TTS)
            myUtterance.rate = 0.4
            myUtterance.pitchMultiplier = 1.2
            myUtterance.postUtteranceDelay = 0.1
            myUtterance.volume = 1
            if BeginViewController.isEnglish {
                myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            }else {
                myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            }
            
            
            synth.speak(myUtterance)
        }
    }
    @IBAction func onTextClick(_ sender: UIButton) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        if textButton.isSelected {
            slider.isHidden = true
            textButton.isSelected = false
        }
            else {
            changeTab(to: textButton)
            slider.isHidden = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerViewSegue" {
            mapNavigationController = segue.destination as! UINavigationController
        }
    }
    func getViewController() {
        hipsterViewController = (self.storyboard?.instantiateViewController(withIdentifier: "HipsterViewController"))! as! HipsterViewController
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(exitMapNoti(noti:)), name: notificationExitMap, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterTextNoti(noti:)), name: notificationEnterText, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitTextNoti(noti:)), name: notificationExitText, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterModeContentNoti(noti:)), name: notificationEnterModeContent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitModeContentNoti(noti:)), name: notificationExitModeContent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pageChangedNoti(noti:)), name: notificationPageChanged, object: nil)
        
    }
    func setInitSelected() {
        selectedViewController = mapNavigationController
        selectedButton = mapButton
    }
    func setTTS() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch{
            }
        }catch{
        }
    }
    func setText(selectLanguage: String) {
        // according to language set text
        infoButton.setTitle("main_info".localized(language: selectLanguage), for: .normal)
        hipsterButton.setTitle("main_diary".localized(language: selectLanguage), for: .normal)
        speechButton.setTitle("main_sound".localized(language: selectLanguage), for: .normal)
        textButton.setTitle("main_font".localized(language: selectLanguage), for: .normal)
        
    }
    func changePage(to newViewController: UIViewController) {
        // Remove previous viewController
        selectedViewController.willMove(toParentViewController: nil)
        selectedViewController.view.removeFromSuperview()
        selectedViewController.removeFromParentViewController()
        
        // Add new viewController
        addChildViewController(newViewController)
        self.mainContainerView.addSubview(newViewController.view)
        newViewController.view.frame = mainContainerView.bounds
        newViewController.didMove(toParentViewController: self)
        
        self.selectedViewController = newViewController
    }
    func changeTab(to newButton: UIButton){
        selectedButton.isSelected = false
        
        newButton.isSelected = true
        
        self.selectedButton = newButton

    }
    func exitMapNoti(noti:Notification) {
        mapButton.isSelected = false
    }
    func enterTextNoti(noti:Notification) {
        TTS = noti.userInfo!["TTS"] as! String
        speechButton.isEnabled = true
        textButton.isEnabled = true
        
    }
    func exitTextNoti(noti:Notification) {
        speechButton.isEnabled = false
        speechButton.isSelected = false
        textButton.isEnabled = false
        textButton.isSelected = false
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        slider.isHidden = true
        
    }
    func enterModeContentNoti(noti:Notification) {
        infoButton.isEnabled = true
        textButton.isEnabled = true
        speechButton.isEnabled = true
        
    }
    func exitModeContentNoti(noti:Notification) {
        infoButton.isEnabled = false
        infoButton.isSelected = false
        textButton.isEnabled = false
        textButton.isSelected = false
        speechButton.isEnabled = false
        speechButton.isSelected = false
        
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        slider.isHidden = true
    }

    func pageChangedNoti(noti:Notification) {
        TTS = noti.userInfo!["TTS"] as! String
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        slider.isHidden = true
        speechButton.isSelected = false
        textButton.isSelected = false
        infoButton.isSelected = false
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        //print(slider.value)
        NotificationCenter.default.post(name: notificationSliderChanged, object: nil, userInfo: ["sliderValue":slider.value])
    }

}
