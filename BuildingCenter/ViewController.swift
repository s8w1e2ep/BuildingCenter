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
        
        /*let zones = databasehelper.queryzoneTable(zoneID: "1")
        print(zones.name)
        let modes = zones.modes
        
        for i in modes!{
            print(i.name)
            let devices = i.devices
            for j in devices!{
                print(j.name,j.company_id)
                //let companys = j.companys?.name
                
                print(j.companys?.name )
            }

        }*/
        
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

