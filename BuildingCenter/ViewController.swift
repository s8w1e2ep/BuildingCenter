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
    var imgdownload: ImageDownload!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databasehelper = Databasehelper()
        //databasehelper.deleteTable()
        databasehelper.creatTable()
        
        //imgdownload.getpic(url: "http://192.168.65.28/web/media/project/project1/zone/photo_1-5638920671c92.jpg")
        //imgdownload.showpic(image: img, url: "")
        /*let beacons = databasehelper.querybeaconTable(mac_ADDR: "E0:E5:CF:2F:AF:C1")
        print(beacons.beacon_id)
        print(beacons.field_name)*/
        /*databasehelper.read_guider()
        databasehelper.read_mode_content()
        let aa = databasehelper.queryhintTable()
        print(aa.hint_id)
        print(aa.guider)
        print(aa.map_info)
        print(aa.mode_content)*/
        
        /*let modes = zones.modes
        
        for i in modes!{
            print(i.name)
            let devices = i.devices
            for j in devices!{
                print(j.name,j.company_id)
                //let companys = j.companys?.name
                
                print(j.companys?.name )
            }

        }*/
        //databasehelper.update_mode_isread(modeID: "5")
        //databasehelper.querymodeTable(zoneID: "1")
        //databasehelper.querymodeTable(zoneID: "2")
        //databasehelper.querymodeTable()
        databasehelper.querymodeTable()
        /*var when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let databasehelper1 = Databasehelper()
            databasehelper1.querymodeTable()
        }
        */
        
        /*let zone = databasehelper.queryzoneTable(zoneID: "2")
        print(zone.is_like)
        databasehelper.updatezonelike(zoneID: "2")
        let zone1 = databasehelper.queryzoneTable(zoneID: "2")
        print(zone1.is_like)*/
        
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

