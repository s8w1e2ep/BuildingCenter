//
//  LandscapeViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//


import UIKit
import AudioToolbox

class LandscapeViewController: UIViewController {
    
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var markImage: UIImageView!
    
    var modeContentViewController: ModeContentViewController!
    
    var modeItem: ModeItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut, .repeat, .autoreverse], animations: { self.highlightImage.alpha = 1 }, completion: {_ in self.markImage.isHidden = false })
        DispatchQueue.main.asyncAfter(deadline: (.now()+1.5), execute: {
            self.highlightImage.layer.removeAllAnimations()
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "landscape_to_mode_content" {
            modeContentViewController = segue.destination as! ModeContentViewController
            modeContentViewController.modeItem = modeItem
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
    func setLayout() {
        let imgdownload = ImageDownload()
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        let bgPath = modeItem.splash_bg_vertical
        let bgIndex = bgPath?.index((bgPath?.startIndex)!, offsetBy: 3)
        let bgImageName = DatabaseUtilizer.filePathURLPrefix + (bgPath?.substring(from: bgIndex!))!
        let hlPath = modeItem.splash_fg_vertical
        let hlIndex = bgPath?.index((hlPath?.startIndex)!, offsetBy: 3)
        let hlImageName = DatabaseUtilizer.filePathURLPrefix + (hlPath?.substring(from: hlIndex!))!
        let markPath = modeItem.splash_blur_vertical
        let markIndex = markPath?.index((markPath?.startIndex)!, offsetBy: 3)
        let markImageName = DatabaseUtilizer.filePathURLPrefix + (markPath?.substring(from: markIndex!))!
        /*bgImage.downloadedFrom(link: bgImageName)
        highlightImage.downloadedFrom(link: hlImageName)
        markImage.downloadedFrom(link: markImageName)*/
        imgdownload.showpic(image: bgImage, url: bgImageName)
        //imgdownload.showpic(image: bgImage, url: "http://60.251.33.54:98/web/media/template/template_2@3x5826cadc1f9151.71960939")
        imgdownload.showpic(image: highlightImage, url: hlImageName)
        imgdownload.showpic(image: markImage, url: markImageName)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
        
        if BeginViewController.isEnglish {
            navBarTitle.title = modeItem.name_en
        }else {
            navBarTitle.title = modeItem.name
        }
    }
    
}
