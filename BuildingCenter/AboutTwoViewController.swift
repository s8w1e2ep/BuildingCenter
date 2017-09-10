//
//  AboutTwoViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class AboutTwoViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nextPage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
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
        navItem.title = "guide_introduction".localized(language: selectLanguage)
        content.text = "tour_content".localized(language: selectLanguage)
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
