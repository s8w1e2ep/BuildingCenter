//
//  ResultViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/10/11.
//  Copyright © 2017年 uscc. All rights reserved.
//
import Foundation
import UIKit
import MessageUI

class ResultViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var QRcodeImageView: UIImageView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sendEmailBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var hipster = NSMutableDictionary()
    var combineImage: UIImage!
    var QRcodeImage: UIImage!
    var image: UIImage!
    var template: UIImage!
    var index: Int!
    var text: String!
    var label: UILabel!
    let currentdate = Date()
    let dateformatter = DateFormatter()
    var imageFileName: String!
    var QRcodeFileName: String!
    var imageData: Data!
    var combineImageData: Data!
    var QRcodeImageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateformatter.dateFormat = "YYYY-MM-dd_HH:mm:ss"
        imageFileName = dateformatter.string(from: currentdate) + ".jpeg"
        creatQRcode()
        combineImage = combine(leftImage: template, rightImage: image)
        imageView.image = combineImage
        combineImageData = UIImagePNGRepresentation(combineImage)
        //updateHipster()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    /*
    func updateHipster(){
        //let json: [String: Any] = ["content": text/*text.cString(using: .utf8)!*/, "picture_name": "", "combine_name": imageFileName, "hipster_template_id": 1, "hipster_text_id": 1, "zone_id": 1, "picture_data": imageData.base64EncodedString(), "combine_data": combineImageData.base64EncodedString()]
     
        self.hipster["content"] = text
        self.hipster["picture_name"] = ""
        self.hipster["combine_name"] = imageFileName
        self.hipster["hipster_template_id"] = 1
        self.hipster["hipster_text_id"] = 1
        self.hipster["zone_id"] = 1
        self.hipster["picture_data"] = UIImageJPEGRepresentation(image!, 0.1)!.base64EncodedString( options: Data.Base64EncodingOptions.init(rawValue: 0))
        self.hipster["combine_data"] = UIImageJPEGRepresentation(combineImage!, 0.1)!.base64EncodedString( options: Data.Base64EncodingOptions.init(rawValue: 0))
        //print(json)

        if let JsonData = try? JSONSerialization.data(withJSONObject: /*json*/self.hipster, options: [])
        {
            
            //print(JsonData)
            let JsontoUtf8 = String(data:JsonData,encoding:.utf8)
            var stringUrl = DatabaseUtilizer.hipsterContentURL + "?hipster_content="
            stringUrl += JsontoUtf8!
            //print(stringUrl)
            
            
            if let encodedURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                let url = NSURL(string: encodedURL)
                do{
                    let html = try String(contentsOf: url! as URL)
                    print(html)
                }catch{
                    print(error)
                }
                
            }
            
            
        }
    }
    */
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        
        QRcodeImageData = UIImagePNGRepresentation(QRcodeImage)
        
        // setToRecipients, setSubject, setMessageBody.
        // ...
        
        // add attachment.
        mailComposerVC.addAttachmentData(combineImageData!, mimeType: "", fileName: imageFileName)
        // error
        //mailComposerVC.addAttachmentData(QRcodeImageData!, mimeType: "", fileName: QRcodeFileName)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func creatQRcode(){
        let str = "http://60.251.33.54:98/web/controller/userController.php?action=logout" as String!
        if let urlString = str{
            let data = urlString.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            
            QRcodeImage = UIImage(ciImage: (filter?.outputImage)!)
            // jpg make sendemail error. use jpeg.
            QRcodeFileName = "1531515346.jpg"
            QRcodeImageView.image = QRcodeImage
        }
    }
    
    func setText(selectLanguage: String){
        saveBtn.setTitle("save_to_phone".localized(language:selectLanguage), for: .normal)
        sendEmailBtn.setTitle("send_mail".localized(language:selectLanguage),for: .normal)
        backBtn.setTitle("back_to_main".localized(language:selectLanguage), for: .normal)
        storeLabel.text = "store_sucess".localized(language:selectLanguage)
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
    
    @IBAction func OnsaveBtnAction(_ sender: Any) {
        let image = self.imageView.image!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        storeView.isHidden = !storeView.isHidden
    }
    
    @IBAction func storegoBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
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
        
        let textImage = text as NSString
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
        let textAttributes = [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont.systemFont(ofSize: 20.0), NSBackgroundColorAttributeName: UIColor.clear] as [String : Any]
        if textImage.length > 13{
            var temptext = textImage.substring(to: 13)
            temptext.draw(at: CGPoint(x: 65, y: 450), withAttributes: textAttributes)
            temptext = textImage.substring(from: 13)
            temptext.draw(at: CGPoint(x: 65, y: 480), withAttributes: textAttributes)
        }
        else{
            textImage.draw(at: CGPoint(x: 65, y: 450), withAttributes: textAttributes)
        }
        let imageLong = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageLong!
    }

}
