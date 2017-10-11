//
//  DeviceImageViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 15/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class DeviceImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    var modeItem: ModeItem!
    var equipmentNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func setLayout(){
        let imgdownload = ImageDownload()
        let path = modeItem.devices?[equipmentNumber].photo
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        //image.downloadedFrom(link: imageName)
        imgdownload.showpic(image: image, url: imageName)
        //image.contentMode = .scaleToFill
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
