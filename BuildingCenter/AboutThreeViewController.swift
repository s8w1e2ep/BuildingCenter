//
//  AboutThreeViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class AboutThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set view background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "about_background.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage, for: .default)
    }

    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
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

}
