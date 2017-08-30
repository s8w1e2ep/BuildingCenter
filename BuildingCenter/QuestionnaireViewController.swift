//
//  QuestionnaireViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/21.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    @IBOutlet var navbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    navbar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn1toQn2", sender: self);
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
