//
//  AboutOneViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class AboutOneViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nextPage: UIButton!
    let databasehelper = Databasehelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        databasehelper.querymodeTable(zoneID: "4")
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        self.performSegue(withIdentifier: "toNext", sender: self);
    }
    
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        // set textView
        content.contentOffset = CGPoint.zero
    }
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "origin_exhibition".localized(language: selectLanguage)
        content.text = "origin_content".localized(language: selectLanguage)
    
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
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
