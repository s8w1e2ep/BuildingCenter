//
//  MainPageViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 08/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import AVFoundation

class MainPageViewController: UIViewController {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var hipsterButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var mainContainerView: UIView!
    var mapNavigationController: UINavigationController!
    var hipsterViewController: HipsterViewController!

    var selectedViewController: UIViewController!
    var selectedButton: UIButton!
    
    // TTS
    var TTS: String!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    // Notification
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    let notificationEnterModeContent = Notification.Name("enterModeContentNoti")
    let notificationExitModeContent = Notification.Name("exitModeContentNoti")
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
        changeTab(to: mapButton)
        changePage(to: mapNavigationController)
        
        mapNavigationController.popToRootViewController(animated: true)//////
    }
    
    @IBAction func onInfoClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: notificationFirmClicked, object: nil, userInfo: nil)
    }
    
    
    @IBAction func onHipsterClick(_ sender: UIButton) {
        changeTab(to: hipsterButton)
        changePage(to: hipsterViewController)
    }
    @IBAction func onSpeechClick(_ sender: UIButton) {
        changeTab(to: speechButton)
        
        myUtterance = AVSpeechUtterance(string: TTS)
        myUtterance.rate = 0.4
        myUtterance.pitchMultiplier = 1.2
        myUtterance.postUtteranceDelay = 0.1
        myUtterance.volume = 1
        myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        
        synth.speak(myUtterance)
    }
    @IBAction func onTextClick(_ sender: UIButton) {
        changeTab(to: textButton)
        slider.isHidden = false
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
        NotificationCenter.default.addObserver(self, selector: #selector(enterTextNoti(noti:)), name: notificationEnterText, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitTextNoti(noti:)), name: notificationExitText, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterModeContentNoti(noti:)), name: notificationEnterModeContent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitModeContentNoti(noti:)), name: notificationExitModeContent, object: nil)
        
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
    
    func enterTextNoti(noti:Notification) {
        TTS = noti.userInfo!["TTS"] as! String
        speechButton.isEnabled = true
        textButton.isEnabled = true
        
    }
    func exitTextNoti(noti:Notification) {
        speechButton.isEnabled = false
        textButton.isEnabled = false
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        slider.isHidden = true
        changeTab(to: mapButton)
    }
    func enterModeContentNoti(noti:Notification) {
        infoButton.isEnabled = true
        
    }
    func exitModeContentNoti(noti:Notification) {
        infoButton.isEnabled = false
        changeTab(to: mapButton)
    }

    @IBAction func sliderChange(_ sender: UISlider) {
        //print(slider.value)
        NotificationCenter.default.post(name: notificationSliderChanged, object: nil, userInfo: ["sliderValue":slider.value])
    }

}
