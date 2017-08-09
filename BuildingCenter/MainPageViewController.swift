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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hipsterViewController = (self.storyboard?.instantiateViewController(withIdentifier: "HipsterViewController"))! as! HipsterViewController
        
        // Set init button and viewController
        selectedViewController = mapNavigationController
        selectedButton = mapButton
        
        // Notification setting
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterTextNoti(noti:)), name: notificationEnterText, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitTextNoti(noti:)), name: notificationExitText, object: nil)
        
        // Some TTS setting
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch{
            }
        }catch{
        }
        //slider.maximumValue = 40
        //slider.minimumValue = 15
        //slider.value = Float((text.font?.pointSize)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onMapClick(_ sender: UIButton) {
        changeTab(to: mapButton)
        changePage(to: mapNavigationController)
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
    @IBAction func sliderChange(_ sender: UISlider) {
        print(slider.value)
        NotificationCenter.default.post(name: notificationSliderChanged, object: nil, userInfo: ["sliderValue":slider.value])
    }

}
