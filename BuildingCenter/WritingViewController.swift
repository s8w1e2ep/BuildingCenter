//
//  WritingViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/9/4.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController {

    var image: UIImage!
    var template: UIImage!
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func nextButtononClick(_ sender: Any) {
        self.performSegue(withIdentifier: "WritingToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagimage = image
        let tagtemplate = template
        let tagindex = index
        let controller = segue.destination as! ResultViewController
        controller.image = tagimage
        controller.template = tagtemplate
        controller.index = tagindex
    }

}
