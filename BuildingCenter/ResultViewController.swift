//
//  ResultViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/10/11.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sendEmailBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var template: UIImage!
    var index: Int!
    var text: String!
    var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("text = \(text)")
        
        
        imageView.image = combine(leftImage: template, rightImage: image)
        setText(selectLanguage: BeginViewController.selectedLanguage)
        // Do any additional setup after loading the view.
    }

    func setText(selectLanguage: String){
        saveBtn.setTitle("save_to_phone".localized(language:selectLanguage), for: .normal)
        sendEmailBtn.setTitle("send_mail".localized(language:selectLanguage),for: .normal)
        backBtn.setTitle("back_to_main".localized(language:selectLanguage), for: .normal)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnMenuBtnAction(_ sender: Any) {
        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func OnbackBtnAction(_ sender: Any) {
        menuView.isHidden = !menuView.isHidden
    }
    
    func reSizeImage(Image: UIImage,reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        Image.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    func combine(leftImage: UIImage, rightImage: UIImage) -> UIImage {
        
        var textImage = text as NSString
        var width = self.view.bounds.width
        var height = self.view.bounds.height
        var x = CGFloat(0)
        var y = CGFloat(0)
        var reSize = CGSize(width: width, height: height)
        let Template = reSizeImage(Image: leftImage,reSize: reSize)
        
        if(index % 2 == 0){
            x = CGFloat(width) * CGFloat(110) / CGFloat(375)
            y = CGFloat(height) * CGFloat(95) / CGFloat(647)
            width = CGFloat(width) * CGFloat(212) / CGFloat(375)
            height = CGFloat(height) * CGFloat(292) / CGFloat(647)
        }
        else{
            x = CGFloat(width) * CGFloat(47) / CGFloat(375)
            y = CGFloat(height) * CGFloat(87) / CGFloat(647)
            width = CGFloat(width) * CGFloat(302) / CGFloat(375)
            height = CGFloat(height) * CGFloat(205) / CGFloat(647)
        }
        reSize = CGSize(width: width, height: height)
        let Image = reSizeImage(Image: rightImage,reSize: reSize)
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
        Template.draw(at: CGPoint(x: 0, y: 0))
        Image.draw(at: CGPoint(x: x, y: y))
        let textAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20.0), NSBackgroundColorAttributeName: UIColor.clear] as [String : Any]
        //let size = textImage.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20.0)])
        textImage.draw(at: CGPoint(x: 65, y: 450), withAttributes: textAttributes)
        let imageLong = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageLong!
    }

}
