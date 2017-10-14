//
//  AreaViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class AreaViewController: UIViewController {
    
    
    @IBOutlet weak var zoneTag: UILabel!
    @IBOutlet weak var zoneName: UITextView!
    @IBOutlet var textView: UITextView!
    
    
    @IBOutlet weak var nextPage: UIButton!
    
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    var databaseHelper: Databasehelper!
    
    var modeSelectViewController: ModeSelectViewController!
    var zoneItem: ZoneItem!
    var modeItems: [ModeItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setNotification()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setContent()
    }
    @IBAction func buttonsound(_ sender: Any) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.post(name: notificationEnterText, object: nil, userInfo: ["TTS":textView.text])
    }
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.post(name: notificationExitText, object: nil, userInfo: ["TTS":textView.text])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "zone_to_mode_select" {
            modeSelectViewController = segue.destination as! ModeSelectViewController
            modeSelectViewController.zoneItem = zoneItem
        }
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChangedNoti(noti:)), name: notificationSliderChanged, object: nil)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
    }
    
    func setContent() {
        zoneTag.text = zoneItem.zone_id
        if BeginViewController.isEnglish {
            zoneName.text = zoneItem.name_en
            textView.text = zoneItem.introduction_en
        }else {
            zoneName.text = zoneItem.name
            textView.text = zoneItem.introduction
            
        }
    }
    func sliderChangedNoti(noti:Notification) {
        let sliderValue = noti.userInfo!["sliderValue"] as! Float
        textView.font = textView.font?.withSize(CGFloat(sliderValue))
    }
}
