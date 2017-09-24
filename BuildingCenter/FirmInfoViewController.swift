//
//  FirmInfoViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 26/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class FirmInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var gradientLayer: CAGradientLayer!
    
    
    var modeItem: ModeItem!
    var equipmentNumber: Int = 0
    
    var deviceName: UILabel!
    var firmInfo: UILabel!
    var company: UILabel!
    var web: UILabel!
    var phone: UILabel!
    var address: UILabel!
    
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
    func setLayout() {
        
        let size = scrollView.bounds.size
        
        let imageView = UIImageView()
        let path = modeItem.devices?[equipmentNumber].photo_vertical
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        imageView.downloadedFrom(link: imageName)
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height*0.35)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        imageView.layer.addSublayer(gradientLayer)
        
        let infoImageView = UIImageView()
        infoImageView.image = UIImage(named: "comanyinfopage_bg.png")
        infoImageView.frame = CGRect(x: 0, y: size.height*0.35, width: size.width, height: (infoImageView.image?.size.height)!)
        //
        deviceName = UILabel(frame: CGRect(x: 0, y: size.height*0.25, width: size.width, height: 20))
        deviceName.textAlignment = .center
        deviceName.textColor = UIColor.white
        deviceName.font = deviceName.font.withSize(28)
        //
        firmInfo = UILabel(frame: CGRect(x: 0, y: size.height*0.3, width: size.width, height: 20))
        firmInfo.textAlignment = .center
        firmInfo.textColor = UIColor.white
        firmInfo.font = firmInfo.font.withSize(15)
        //
        company = UILabel(frame: CGRect(x: size.width*0.2, y: size.height*0.35 + 25, width: size.width, height: 20))
        
        web = UILabel(frame: CGRect(x: size.width*0.2, y: size.height*0.35 + 85, width: size.width, height: 20))
        
        phone = UILabel(frame: CGRect(x: size.width*0.2, y: size.height*0.35 + 145, width: size.width, height: 20))
        
        address = UILabel(frame: CGRect(x: size.width*0.2, y: size.height*0.35 + 205, width: size.width, height: 20))
        address.text = ""
        //let QRcode
        
        
        scrollView.contentSize = CGSize(
            width: size.width,
            height: size.height*0.6 + infoImageView.bounds.size.height
        )
        scrollView.addSubview(imageView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(infoImageView)
        
        scrollView.addSubview(deviceName)
        scrollView.addSubview(firmInfo)
        scrollView.addSubview(company)
        scrollView.addSubview(web)
        scrollView.addSubview(phone)
        scrollView.addSubview(address)
        
        
            /*
            let label = UILabel(frame: CGRect(x: 0, y: size.height*0.83, width: size.width * (1-pageCutRate*2), height: 20))
            label.text = course["name"]
            label.textAlignment = .center
            label.textColor = UIColor.white
            //label.font = UIFont(name: "Helvetica-Light", size: 24)
            label.font = label.font.withSize(25)
            */

    
    }
    func setText() {
        firmInfo.text = "equipment_manufacture_info".localized(language: BeginViewController.selectedLanguage)
        
        company.text = modeItem.devices?[equipmentNumber].companys?.name_en
        web.text = modeItem.devices?[equipmentNumber].companys?.web
        phone.text = modeItem.devices?[equipmentNumber].companys?.tel
        address.text = modeItem.devices?[equipmentNumber].companys?.addr
        //address.text = modeItem.devices?[equipmentNumber].companys?.
        if BeginViewController.isEnglish {
            deviceName.text = modeItem.devices?[equipmentNumber].name_en
        }else {
            deviceName.text = modeItem.devices?[equipmentNumber].name
        }

    }
    
}
