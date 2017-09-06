//
//  ModeContentDetailViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 05/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentDetailViewController: UIViewController {

    
    let notificationFirmClicked = Notification.Name("firmClickedNoti")
    
    lazy var firmInfoViewController: FirmInfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FirmInfo"))! as! FirmInfoViewController

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(firmClickedNoti(noti:)), name: notificationFirmClicked, object: nil)
        
        
    }
    func firmClickedNoti(noti:Notification) {
        addChildViewController(firmInfoViewController)
        view.addSubview(firmInfoViewController.view)
        firmInfoViewController.didMove(toParentViewController: self)
        
    }

    

}
