//
//  ModeContentDetailViewController2.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 05/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentDetailViewController2: ModeContentDetailViewController {

    @IBOutlet weak var equipmentTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLayout()
        setText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail2_to_image" {
            let deviceImageViewController = segue.destination as! DeviceImageViewController
            deviceImageViewController.modeItem = modeItem
            deviceImageViewController.equipmentNumber = equipmentNumber
            
        }
    }

    func setLayout(){
        let path = modeItem.devices?[equipmentNumber].photo
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        image.downloadedFrom(link: imageName)
        image.contentMode = .scaleAspectFill
        
    }
    func setText() {
        if BeginViewController.isEnglish {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name_en
            textView.text = modeItem.devices?[equipmentNumber].introduction_en
        }else {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name
            textView.text = modeItem.devices?[equipmentNumber].introduction
        }
        TTS = textView.text
        
    }
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChangedNoti(noti:)), name: notificationSliderChanged, object: nil)
    }
    func sliderChangedNoti(noti:Notification) {
        let sliderValue = noti.userInfo!["sliderValue"] as! Float
        textView.font = textView.font?.withSize(CGFloat(sliderValue))
    }
    


}
