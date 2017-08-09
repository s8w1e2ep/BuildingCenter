//
//  AreaViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChangedNoti(noti:)), name: notificationSliderChanged, object: nil)
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
    
    func sliderChangedNoti(noti:Notification) {
        let sliderValue = noti.userInfo!["sliderValue"] as! Float
        textView.font = textView.font?.withSize(CGFloat(sliderValue))
    }
}
