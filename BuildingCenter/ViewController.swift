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
    //var databasehelper: Databasehelper!
    //var database: Database!
    var imgdownload: ImageDownload!
    
    var canPerformSegue = true
    var timeout = 0.0
    var myTimer:Timer?
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var loadingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let databasehelper = Databasehelper()
        
        
        
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
        /*let q = DispatchQueue.main
        let q1 = DispatchQueue(label:"q1")
        let q2 = DispatchQueue(label:"q2")
        q.async {
            databasehelper.querymodeTable(zoneID: "5")
        }
        
        q.async {
            databasehelper.querymodeTable(zoneID: "6")
        }
        q1.async {
            databasehelper.querymodeTable(zoneID: "1")
        }
        q1.async {
            databasehelper.querymodeTable(zoneID: "3")
        }
        q2.async {
            databasehelper.querymodeTable(zoneID: "2")
        }
        q2.sync {
            databasehelper.querymodeTable(zoneID: "4")
        }*/
        
        
        
        
        
        //databasehelper.querymodeTable()
        /*var when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let databasehelper1 = Databasehelper()
            databasehelper1.querymodeTable()
        }
        */
        /*
        let zone = databasehelper.queryzoneTable(zoneID: "2")
        print("a")
        
        print(zone.is_like)
        databasehelper.updatezonelike(zoneID: "2")
        let zone1 = databasehelper.queryzoneTable(zoneID: "2")
        print("b")
        print(zone1.is_like)
        */
        
        /*let m1 = databasehelper.querymodeTable(zoneID: "1")
        let d1 = databasehelper.querydeviceTable(modeID: "1")
        for i in m1{
            print(i.mode_id)
            print(i.is_like)
        }
        databasehelper.updatedevicelike(deviceID: "1")
        let m2 = databasehelper.querymodeTable(zoneID: "1")
        let d2 = databasehelper.querydeviceTable(modeID: "1")
        for i in m2{
            print(i.mode_id)
            print(i.is_like)
        }*/
        
        
        
        
        let hi = databasehelper.querytemplateTable()
        for i in hi{
            //print(i.hipster_template_id)
            print(i.template)
        }
        
       /*let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            let databasehelper1 = Databasehelper()
            databasehelper1.querymodeTable()
            group.leave()
            
        }
        
        // wait ...
        group.wait()
        
        // ... and return as soon as "a" has a value
        
        // does not wait. But the code in notify() is run
        // after enter() and leave() calls are balanced
        
        group.notify(queue: .main) {
            print("done")
        }*/

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //self.performSegue(withIdentifier: "downloadToBegin", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let databasehelper = Databasehelper()
        let documnets:String = NSHomeDirectory() + "/Documents/"
        let fileManager = FileManager.default
        let dirContents = try? fileManager.contentsOfDirectory(atPath: documnets)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseOut, .repeat, .autoreverse], animations: { self.loadingLabel.alpha = 0.2 }, completion: nil)
        
        
        databasehelper.queryzoneDownload()
        databasehelper.querymodeTable(zoneID: "1")
        databasehelper.querymodeTable(zoneID: "2")
        databasehelper.querymodeTable(zoneID: "3")
        databasehelper.querymodeTable(zoneID: "4")
        databasehelper.querymodeTable(zoneID: "5")
        databasehelper.querymodeTable(zoneID: "6")
        databasehelper.querymodeTable(zoneID: "7")
        //databasehelper.querymodeTable(zoneID: "8")
        //databasehelper.querymodeTable(zoneID: "9")
        //databasehelper.querymodeTable(zoneID: "10")
        //databasehelper.querymodeTable(zoneID: "11")
        var out = 0
        
        
        myTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector:
            #selector(ViewController.showProgressView),
            userInfo: ["test":"for userInfo test"],
            repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showProgressView() {
        timeout += 1.0
        let documnets:String = NSHomeDirectory() + "/Documents/"
        let fileManager = FileManager.default
        //let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let dirContents = try? fileManager.contentsOfDirectory(atPath: documnets)

        self.progressView.setProgress(Float((dirContents?.count)!)/120.0, animated: true)
        print(Float((dirContents?.count)!))
        

        if ((dirContents?.count)! >= 120 && canPerformSegue) {
            print("yes")
            self.performSegue(withIdentifier: "downloadToBegin", sender: nil)
            canPerformSegue = false
            myTimer?.invalidate()
        }
        if(timeout >= 60) {
            let databasehelper = Databasehelper()
            databasehelper.queryzoneDownload()
            databasehelper.querymodeTable(zoneID: "1")
            databasehelper.querymodeTable(zoneID: "2")
            databasehelper.querymodeTable(zoneID: "3")
            databasehelper.querymodeTable(zoneID: "4")
            databasehelper.querymodeTable(zoneID: "5")
            databasehelper.querymodeTable(zoneID: "6")
            databasehelper.querymodeTable(zoneID: "7")
            //databasehelper.querymodeTable(zoneID: "8")
            //databasehelper.querymodeTable(zoneID: "9")
            //databasehelper.querymodeTable(zoneID: "10")
            //databasehelper.querymodeTable(zoneID: "11")
            timeout = 0
        }
    }
    
    
    
}

