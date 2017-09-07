//
//  ViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit
import Foundation
import SQLite

class ViewController: UIViewController {
    var databasehelper: Databasehelper!
    //var database: Database!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databasehelper = Databasehelper()
        //databasehelper.deletezonetable()
        databasehelper.createdeviceTable()
        let devices = databasehelper.querydeviceTable();
        for i in devices{
            print(((i as! DeviceItem).name)as! String)
            print(((i as! DeviceItem).introduction)as! String)
        }
        //print((zones[0] as! ZoneItem).name)
        //let stringUrl = "http://192.168.65.28/interface/survey.php?survey={\"gender\":\"1\",\"age\":\"3\"}"
        //databasehelper.surveyupload(stringUrl: stringUrl)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.performSegue(withIdentifier: "downloadToBegin", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        

}

