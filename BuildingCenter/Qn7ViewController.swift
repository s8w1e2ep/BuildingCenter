//
//  Qn7ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn7ViewController: UIViewController {

    var survey2 = NSMutableDictionary()
    
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
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn7toQn8", sender: self);
    }
    
    
    func setText(selectLanguage: String) {
        // according to language set text
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn7 : Qn7ViewController = segue.destination as? Qn7ViewController{
            qn7.survey2 = self.survey2
        }
    }
 

}
