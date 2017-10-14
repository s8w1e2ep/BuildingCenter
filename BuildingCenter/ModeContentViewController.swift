//
//  ModeContentViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class ModeContentViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var thumbButton: UIBarButtonItem!
    // test scroller button
    
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var viewInScroll: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    let databaseHelper = Databasehelper()
    
    let notificationEnterModeContent = Notification.Name("enterModeContentNoti")
    let notificationExitModeContent = Notification.Name("exitModeContentNoti")
    
    var modeItem: ModeItem!
    
    var buttons = [UIButton]()
    var selectedNumber: Int = 0
    var selectedButton: UIButton!
    var pageViewController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setLayout()
        setText()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (databaseHelper.queryhintTable().mode_content == "0") {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ModeContentHint"){
                present(vc, animated: true)
            }
            databaseHelper.read_mode_content()
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
            pageViewController.modeItem = modeItem
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
    
    @IBAction func onThumbClick(_ sender: UIBarButtonItem) {
        thumbButton.image = UIImage(named: "thumbup_orange.png")
        thumbButton.tintColor = UIColor.orange
    }
    
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        let size = scrollView.bounds.size
        scrollView.contentSize = CGSize(
            width: CGFloat(size.width * 0.3) * CGFloat((modeItem.devices?.count)!),
            height: size.height
        )
        //viewInScroll.bounds.size = scrollView.contentSize
        for index in 0 ... (modeItem.devices?.count)!-1 {
            print(index)
            let button = UIButton()
            button.frame = CGRect(x: CGFloat(index) * size.width * 0.3, y: 0,
                width: size.width * 0.3, height: size.height)
            button.tag = index
            button.addTarget(self, action: #selector(showPage), for: .touchUpInside)
            button.setTitle("equip".localized(language: BeginViewController.selectedLanguage)+" \(index+1)", for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setBackgroundImage(UIImage(named: "header_blank.png"), for: .selected)
            button.isSelected = false
            scrollView.addSubview(button)
            buttons.append(button)
        }
        // init select
        selectedNumber = 0
        selectedButton = buttons[selectedNumber]
        changeTab(to: selectedButton)
        
    }
    func setText() {
        if BeginViewController.isEnglish {
            navBarTitle.title = modeItem.name_en
        }else {
            navBarTitle.title = modeItem.name
        }
    }
    func showPage(sender: UIButton) {
        changeTab(to: buttons[sender.tag])
        pageViewController.showPage(byIndex: sender.tag)
    }
    
    func changeTab(byIndex index: Int) {
        changeTab(to: buttons[index])
    }
    func changeTab(to newButton: UIButton) {
        // 先利用 tintColor 取得 Button 預設的文字顏色
        // 將目前選取的按鈕改成未選取的顏色
        //selectedButton.backgroundColor = UIColor.white
        selectedButton.isSelected = false
        // 將參數傳來的新按鈕改成選取的顏色
        //newButton.backgroundColor = UIColor.init(red: 0x00/255, green: 0xBB/255, blue: 0xFF/255, alpha: 1)
        newButton.isSelected = true
        // 將目前選取的按鈕改為新的按鈕
        selectedButton = newButton
        
        //set scroll contentOffset
        let size = scrollView.bounds.size
        var targetContentOffset = scrollView.contentOffset.x
        let currentContentOffset = scrollView.contentOffset.x
        let currentMaxContentOffset = scrollView.contentOffset.x + size.width
        if CGFloat(selectedButton.tag+1) * size.width * 0.3 > currentMaxContentOffset {
            targetContentOffset = (CGFloat(selectedButton.tag+1)*0.3 - 1) * size.width
        }
        if CGFloat(selectedButton.tag) * size.width * 0.3 < currentContentOffset {
            targetContentOffset = CGFloat(selectedButton.tag) * size.width * 0.3
        }
        scrollView.contentOffset.x = targetContentOffset
    }
    
    
}

