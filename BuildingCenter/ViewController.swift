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
        //databasehelper.deleteTable()
        databasehelper.creatTable()
        //databasehelper.getzone(zoneID: "1")
        //let devices = databasehelper.querydeviceTable(modeID:"1");
        let modes = databasehelper.querymodeTable(zoneID: "1")
        
        for i in modes{
            print(i.name)
            //let devices = databasehelper.querydeviceTable(modeID:i.mode_id!)
            let devices = i.devices
            for j in devices!{
                print(j.name,j.company_id)
                //let companys = j.companys?.name
                
                print(j.companys?.company_id )
            }
            //print(((i as! ModeItem).name)as! String)
            //print(((i as! CompanyItem).web)as! String)
        }
        
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

