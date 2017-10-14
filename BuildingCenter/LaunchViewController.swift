//
//  LaunchViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/8/4.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    let databasehelper = Databasehelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        databasehelper.querymodeTable(zoneID: "1")
        // fade in animation
        UIView.animate(withDuration: 3.0, animations: {
            self.logo.alpha = 1.0
        }, completion: {
            (finish1: Bool) in
            self.performSegue(withIdentifier: "launchToDownload", sender: nil)
        })
        
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
