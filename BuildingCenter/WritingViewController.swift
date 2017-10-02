//
//  WritingViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/9/4.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var template: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
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
