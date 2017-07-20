//
//  FeedbackHintViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 20/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class FeedbackHintViewController: UIViewController {
    
    
    @IBOutlet weak var cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cancel.addTarget(self, action: #selector(MapInstructionViewController.dismissViewController), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
