//
//  InfoHintViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 29/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class InfoHintViewController: UIViewController {

    @IBOutlet var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
    }
    @IBAction func onClick(_ sender: UIButton) {
        self.myView.isHidden = true
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
