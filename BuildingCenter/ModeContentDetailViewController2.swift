//
//  ModeContentDetailViewController2.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 05/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentDetailViewController2: UIViewController {

    @IBOutlet weak var equipmentTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var modeItem: ModeItem!
    var equipmentNumber: Int = 0
    var isShowed: Bool = false
    
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
    

    func setLayout(){
        let path = modeItem.devices?[equipmentNumber].photo_vertical
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        image.downloadedFrom(link: imageName)
    }
    func setText() {
        if BeginViewController.isEnglish {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name_en
            textView.text = modeItem.devices?[equipmentNumber].introduction_en
        }else {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name
            textView.text = modeItem.devices?[equipmentNumber].introduction
        }
        
    }


}
