//
//  FeedbackHintViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 20/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class FeedbackHintViewController: UIViewController{
    
    @IBOutlet weak var feedbackTitle: UILabel!
    @IBOutlet weak var feedbackText: UILabel!
    
    @IBOutlet weak var feedbackYes: UIButton!
    @IBOutlet weak var cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setButtonAction()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clkToQn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "feedbackhintToQn", sender: self)
        
    }
    func setButtonAction() {
        cancel.addTarget(self, action: #selector(self.dismissViewController), for: .touchUpInside)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        
        feedbackTitle.text = "feedback_title".localized(language: selectLanguage)
        feedbackText.text = "feedback_text".localized(language: selectLanguage)
        feedbackYes.setTitle("feedback_yes".localized(language: selectLanguage), for: .normal)
        cancel.setTitle("feedback_no".localized(language: selectLanguage), for: .normal)
        
    }
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
