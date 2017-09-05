//
//  GuiderHintViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 29/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class GuiderHintViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var understand: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func setText(selectLanguage: String) {
        // according to language set text
        
        content.text = "tour_select_guide".localized(language: selectLanguage)
        
        understand.setTitle("understand".localized(language: selectLanguage), for: .normal)
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
