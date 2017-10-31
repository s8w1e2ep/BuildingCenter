//
//  EmptyViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 31/10/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    var modeItem: ModeItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        if BeginViewController.isEnglish {
            navBarTitle.title = modeItem.name_en
        }else {
            navBarTitle.title = modeItem.name
        }
    }
}
