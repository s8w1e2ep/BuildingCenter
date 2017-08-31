//
//  DownloadViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {

    static let defaults = UserDefaults.standard
    static let GET_IS_ENGLISH: String = "GET_IS_ENGLISH";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Default value forkey GET_IS_ENGLISH is false.
        //BeginViewController.defaults.bool(forKey: BeginViewController.GET_IS_ENGLISH)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickChinese(_ sender: UIButton) {
        // Set value forkey GET_IS_ENGLISH false.
        BeginViewController.defaults.set(false, forKey: BeginViewController.GET_IS_ENGLISH)
        performSegue(withIdentifier: "BeginToAboutOne", sender: self)
    }
    @IBAction func onClickEnglish(_ sender: UIButton) {
        // Set value forkey GET_IS_ENGLISH true.
        BeginViewController.defaults.set(true, forKey: BeginViewController.GET_IS_ENGLISH)
        performSegue(withIdentifier: "BeginToAboutOne", sender: self)
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
