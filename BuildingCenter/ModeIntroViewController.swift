//
//  ModeIntroViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//


import UIKit
import AudioToolbox

class ModeIntroViewController: UIViewController {
    
    @IBOutlet weak var thumbButton: UIBarButtonItem!
    @IBOutlet weak var modeName: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    var landscapeViewController: LandscapeViewController!
    let databaseHelper = Databasehelper()
    var zoneItem: ZoneItem!
    var selectedCell: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initThumb()
        setLayout()
        setNotification()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setContent()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.post(name: notificationEnterText, object: nil, userInfo: ["TTS":textView.text])
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: notificationExitText, object: nil, userInfo: ["TTS":textView.text])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mode_intro_to_landscape" {
            landscapeViewController = segue.destination as! LandscapeViewController
            landscapeViewController.modeItem = zoneItem.modes?[selectedCell]
        }
    }

    @IBAction func buttonsound(_ sender: Any) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func initThumb(){
        if( zoneItem.modes![selectedCell].is_like == "1")
        {
            thumbButton.image = UIImage(named: "thumbup_orange.png")
            thumbButton.tintColor = UIColor.orange
        }
    }
    
    @IBAction func onThumbClick(_ sender: UIBarButtonItem) {
        if( zoneItem.modes![selectedCell].is_like == "0"){
            thumbButton.image = UIImage(named: "thumbup_orange.png")
            thumbButton.tintColor = UIColor.orange
        
            zoneItem.modes![selectedCell].is_like = "1"

            databaseHelper.updatemodelike(modeID: zoneItem.modes![selectedCell].mode_id!)
            
            //upload count
            let mode = NSMutableDictionary()
            mode["mode_id"] = zoneItem.modes![selectedCell].mode_id
            mode["read_count"] = 1
            mode["like_count"] = 1
        
            if let JsonData = try? JSONSerialization.data(withJSONObject: mode, options: [])
            {
                let JsontoUtf8 = String(data:JsonData,encoding:.utf8)
                var stringUrl = DatabaseUtilizer.modeaddURL + "?mode_counts="
                stringUrl += JsontoUtf8!
                print(stringUrl)
            
                if let encodedURL =               stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
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
    }
    
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        // set image
        let path = zoneItem.modes![selectedCell].splash_bg_vertical
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        //cell.backImage.downloadedFrom(link: imageName)
        let imgdownload = ImageDownload()
        //imgdownload.sessionSimpleDownload(urlpath: imageName)
        imgdownload.showpic(image: backgroundImage, url: imageName)
    }
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChangedNoti(noti:)), name: notificationSliderChanged, object: nil)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
        if BeginViewController.isEnglish {
            navBarTitle.title = zoneItem.name_en
        }else {
            navBarTitle.title = zoneItem.name
        }
    }
    func setContent() {
        if BeginViewController.isEnglish {
            modeName.text = zoneItem.modes?[selectedCell].name_en
            textView.text = zoneItem.modes?[selectedCell].introduction_en
        }else {
            modeName.text = zoneItem.modes?[selectedCell].name
            textView.text = zoneItem.modes?[selectedCell].introduction
        }
        
    }
    func sliderChangedNoti(noti:Notification) {
        let sliderValue = noti.userInfo!["sliderValue"] as! Float
        textView.font = textView.font?.withSize(CGFloat(sliderValue))
    }
}
