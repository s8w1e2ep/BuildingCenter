//
//  FirmInfoViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 26/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class FirmInfoViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var equipmentTitle: UILabel!
    
    var equipmentNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        equipmentTitle.text = equipmentTitle.text!+"\(equipmentNumber+1)"
        image.image = UIImage(named: "a1m\(equipmentNumber+1)_bg")
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
