//
//  Q10ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/16.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q10ViewController: UIViewController {

    @IBOutlet var navbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }
    @IBAction func clkPass(_ sender: Any) {
        self.performSegue(withIdentifier: "Q10toQ11", sender: self);
    }
    @IBAction func clk1(_ sender: Any) {
        self.performSegue(withIdentifier: "Q10toQ11", sender: self);
    }
    @IBAction func clk2(_ sender: Any) {
        self.performSegue(withIdentifier: "Q10toQ11", sender: self);
    }
    @IBAction func clk3(_ sender: Any) {
        self.performSegue(withIdentifier: "Q10toQ11", sender: self);
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
