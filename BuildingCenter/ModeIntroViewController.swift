//
//  ModeIntroViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//


import UIKit

class ModeIntroViewController: UIViewController {
    
    @IBOutlet weak var thumbButton: UIBarButtonItem!
    @IBOutlet weak var modeName: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var nextPage: UIButton!
    
    let notificationEnterText = Notification.Name("enterTextNoti")
    let notificationExitText = Notification.Name("exitTextNoti")
    
    let notificationSliderChanged = Notification.Name("sliderChangedNoti")
    
    var landscapeViewController: LandscapeViewController!
    
    var zoneItem: ZoneItem!
    var selectedCell: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onThumbClick(_ sender: UIBarButtonItem) {
        thumbButton.image = UIImage(named: "thumbup_orange.png")
        thumbButton.tintColor = UIColor.orange
    }
    
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
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
