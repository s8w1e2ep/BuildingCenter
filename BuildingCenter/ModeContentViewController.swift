//
//  ModeContentViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var thumbButton: UIBarButtonItem!
    // test scroller button
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    
    @IBOutlet weak var containerView: UIView!
    
    let notificationEnterModeContent = Notification.Name("enterModeContentNoti")
    let notificationExitModeContent = Notification.Name("exitModeContentNoti")
    
    var modeItem: ModeItem!
    
    var selectedButton: UIButton!
    var pageViewController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setLayout()
        sextText()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isModeContentLaunchBefore = defaults.bool(forKey: "isModeContentLaunchBefore")
        
        if (!isModeContentLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ModeContentHint"){
                //show(vc, sender: self)
                present(vc, animated: true)
                
            }
            defaults.set(true, forKey: "isModeContentLaunchBefore")
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: notificationEnterModeContent, object: nil, userInfo: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: notificationExitModeContent, object: nil, userInfo: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerViewSegue" {
            pageViewController = segue.destination as! PageViewController
            pageViewController.mainViewController = self
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
        
        
        // init select
        selectedButton = button1
        changeTab(to: button1)
    }
    func setText() {
        if BeginViewController.isEnglish {
            navBarTitle.title = modeItem.name_en
        }else {
            navBarTitle.title = modeItem.name
        }
    }
    @IBAction func showPage1(_ sender: Any) {
        changeTab(to:button1)
        pageViewController.showPage(byIndex: 0)
    }
    
    @IBAction func showPage2(_ sender: Any) {
        changeTab(to: button2)
        pageViewController.showPage(byIndex: 1)
    }
    
    @IBAction func showPage3(_ sender: Any) {
        changeTab(to: button3)
        pageViewController.showPage(byIndex: 2)
    }
    
    @IBAction func showPage4(_ sender: Any) {
        changeTab(to: button4)
        pageViewController.showPage(byIndex: 3)
    }
    
    @IBAction func showPage5(_ sender: Any) {
        changeTab(to: button5)
        pageViewController.showPage(byIndex: 4)
    }
    
    
    func changeTab(byIndex index: Int) {
        switch index {
        case 0: changeTab(to: button1)
        case 1: changeTab(to: button2)
        case 2: changeTab(to: button3)
        case 3: changeTab(to: button4)
        case 4: changeTab(to: button5)
        default: return
        }
    }
    func changeTab(to newButton: UIButton) {
        // 先利用 tintColor 取得 Button 預設的文字顏色
        let defaultColor = selectedButton.tintColor
        // 將目前選取的按鈕改成未選取的顏色
        selectedButton.backgroundColor = UIColor.white
        selectedButton.setTitleColor(defaultColor, for: .normal)
        // 將參數傳來的新按鈕改成選取的顏色
        newButton.backgroundColor = UIColor.lightGray
        newButton.setTitleColor(UIColor.black, for: .normal)
        // 將目前選取的按鈕改為新的按鈕
        selectedButton = newButton
    }
}
