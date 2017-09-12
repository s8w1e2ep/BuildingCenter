////
//  Databasehelper.swift
//  BuildingCenter
//
//  Created by uscc on 2017/8/23.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation
import SQLite

class Databasehelper {
    let databaseFileName = "buildingcenterdb.sqlite"
    let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\("buildingcenterdb.sqlite")"
    //let ip = "http://60.251.33.54:98"
    //let ip = "http://192.168.65.28"
    func deleteZoneTable(){
        do{
            let db = try Connection(databaseFilePath)
            let zone = Table("zone")
            try db.run(zone.drop(ifExists: true))
        }catch {
            print(error)
        }
    }
    
    func deleteModeTable(){
        do{
            let db = try Connection(databaseFilePath)
            let mode = Table("mode")
            try db.run(mode.drop(ifExists: true))
        }catch {
            print(error)
        }
    }
    
    func deleteDeviceTable(){
        do{
            let db = try Connection(databaseFilePath)
            let device = Table("device")
            try db.run(device.drop(ifExists: true))
        }catch {
            print(error)
        }
    }
    
    func deleteCompanyTable(){
        do{
            let db = try Connection(databaseFilePath)
            let company = Table("company")
            try db.run(company.drop(ifExists: true))
        }catch {
            print(error)
        }
    }
    
    /*func surveyupload(stringUrl: String){
        //let stringUrl = "http://192.168.65.28/interface/survey.php?survey={\"gender\":\"1\",\"age\":\"3\"}"
        if let encodedURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let _ = URL(string: encodedURL) {
            let url2 = NSURL(string: encodedURL)
            
            do{
             let html = try String(contentsOf: url2! as URL)
             print(html)
             }catch{
             print(error)
             }
        }
        
    };*/
    
    func creatTable(){
        createzoneTable()
        createmodeTable()
        createcompanyTable()
        createdeviceTable()
    }
    
    func deleteTable(){
        deleteZoneTable()
        deleteDeviceTable()
        deleteCompanyTable()
        deleteModeTable()
    }
    
    func createzoneTable() {
        /*let zone_id = Expression<String?>("zone_id")
        let name = Expression<String?>("name")
        let name_en = Expression<String?>("name_en")
        let introduction = Expression<String?>("introduction")
        let introduction_en = Expression<String?>("introduction_en")
        let guide_voice = Expression<String?>("guide_voice")
        let guide_voice_en = Expression<String?>("guide_voice_en")
        let hint = Expression<String?>("hint")
        let photo = Expression<String?>("photo")
        let photo_vertical = Expression<String?>("photo_vertical")
        let field_id = Expression<String?>("field_id")
        */
        //let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
        //let db = try Connection(databaseFilePath)
        //let url = URL(string: "http://192.168.65.28/interface/getfile.php?data=zone")
        //let url = URL(string: ip+"/interface/getfile.php?data=zone")
        let url = URL(string:DatabaseUtilizer.downloadURL + "?data=zone")
        do{
            let db = try Connection(databaseFilePath)
            let zone = Table("zone")
            try db.run(zone.create(ifNotExists: true) { t in
                t.column(DBColExpress.zone_id)
                t.column(DBColExpress.name)
                t.column(DBColExpress.name_en)
                t.column(DBColExpress.introduction)
                t.column(DBColExpress.introduction_en)
                t.column(DBColExpress.guide_voice)
                t.column(DBColExpress.guide_voice_en)
                t.column(DBColExpress.hint)
                t.column(DBColExpress.photo)
                t.column(DBColExpress.photo_vertical)
                t.column(DBColExpress.field_id)
            })
            
            if let data = try? Data(contentsOf: url!){
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options:.allowFragments){
                    for p in jsonObj as! [[String: Any]]{
                        var p = p
                        if((p["introduction_en"] as? String)?.isEmpty)!{
                            p["introduction_en"] = ""
                        }
                        if((p["guide_voice"] as? String) == nil){
                            p["guide_voice"] = ""
                        }
                        if((p["guide_voice_en"] as? String) == nil){
                            p["guide_voice_en"] = ""
                        }
                        if((p["photo"] as? String)?.isEmpty)!{
                            p["photo"] = ""
                        }
                        if((p["photo_vertical"] as? String)?.isEmpty)!{
                            p["photo_vertical"] = ""
                        }
                        let filtering = Table("zone").filter(DBColExpress.name == p["name"] as? String)
                        //print(filtering)
                        let plucking = try db.pluck(filtering)
                        if (plucking != nil) {
                            try db.run(filtering.update(DBColExpress.zone_id <- p["zone_id"] as? String ,
                                                   DBColExpress.name <- (p["name"] as? String),
                                                   DBColExpress.name_en <- (p["name_en"] as? String),
                                                   DBColExpress.introduction <- (p["introduction"] as? String),
                                                   DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                                   DBColExpress.guide_voice <- (p["guide_voice"] as? String),
                                                   DBColExpress.guide_voice_en <- (p["guide_voice_en"] as? String),
                                                   DBColExpress.hint <- (p["hint"] as? String),
                                                   DBColExpress.photo <- (p["photo"] as? String),
                                                   DBColExpress.photo_vertical <- (p["photo_vertical"] as? String),
                                                   DBColExpress.field_id <- (p["field_id"] as? String)))
                        }
                        else{
                            try db.run(zone.insert(DBColExpress.zone_id <- p["zone_id"] as? String ,
                                               DBColExpress.name <- (p["name"] as? String),
                                               DBColExpress.name_en <- (p["name_en"] as? String),
                                               DBColExpress.introduction <- (p["introduction"] as? String),
                                            DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                            DBColExpress.guide_voice <- (p["guide_voice"] as? String),
                                            DBColExpress.guide_voice_en <- (p["guide_voice_en"] as? String),
                                            DBColExpress.hint <- (p["hint"] as? String),
                                            DBColExpress.photo <- (p["photo"] as? String),
                                            DBColExpress.photo_vertical <- (p["photo_vertical"] as? String),
                                            DBColExpress.field_id <- (p["field_id"] as? String)
                            ))
                        }
                        
                    }
                }
            }
        }
        catch {
            print(error)
        }
        
    }
    
    func createmodeTable() {
        
        let url = URL(string:DatabaseUtilizer.downloadURL + "?data=mode")
        do{
            let db = try Connection(databaseFilePath)
            let mode = Table("mode")
            try db.run(mode.create(ifNotExists: true) { t in
                t.column(DBColExpress.mode_id)
                t.column(DBColExpress.name)
                t.column(DBColExpress.name_en)
                t.column(DBColExpress.introduction)
                t.column(DBColExpress.introduction_en)
                t.column(DBColExpress.guide_voice)
                t.column(DBColExpress.guide_voice_en)
                t.column(DBColExpress.video)
                t.column(DBColExpress.splash_bg_vertical)
                t.column(DBColExpress.splash_fg_vertical)
                t.column(DBColExpress.splash_blur_vertical)
                t.column(DBColExpress.zone_id)
            })
            
            if let data = try? Data(contentsOf: url!){
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options:.allowFragments){
                    for p in jsonObj as! [[String: Any]]{
                        var p = p
                        if((p["introduction_en"] as? String)?.isEmpty)!{
                            p["introduction_en"] = ""
                        }
                        if((p["guide_voice"] as? String) == nil){
                            p["guide_voice"] = ""
                        }
                        if((p["guide_voice_en"] as? String) == nil){
                            p["guide_voice_en"] = ""
                        }
                        if((p["video"] as? String) == nil){
                            p["video"] = ""
                        }
                        let filtering = Table("mode").filter(DBColExpress.mode_id == p["mode_id"] as? String)
                        let plucking = try db.pluck(filtering)
                        if (plucking != nil) {
                            try db.run(filtering.update(DBColExpress.mode_id <- p["mode_id"] as? String ,
                                                   DBColExpress.name <- (p["name"] as? String),
                                                   DBColExpress.name_en <- (p["name_en"] as? String),
                                                   DBColExpress.introduction <- (p["introduction"] as? String),
                                                   DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                                   DBColExpress.guide_voice <- (p["guide_voice"] as? String),
                                                   DBColExpress.guide_voice_en <- (p["guide_voice_en"] as? String),
                                                   DBColExpress.video <- (p["video"] as? String),
                                                   DBColExpress.splash_bg_vertical <- (p["splash_bg_vertical"] as? String),
                                                   DBColExpress.splash_fg_vertical <- (p["splash_fg_vertical"] as? String),
                                                   DBColExpress.splash_blur_vertical <- (p["splash_blur_vertical"] as? String),
                                                   DBColExpress.zone_id <- (p["zone_id"] as? String)
                            ))
                        }
                        else{
                        
                        try db.run(mode.insert(DBColExpress.mode_id <- p["mode_id"] as? String ,
                                               DBColExpress.name <- (p["name"] as? String),
                                               DBColExpress.name_en <- (p["name_en"] as? String),
                                               DBColExpress.introduction <- (p["introduction"] as? String),
                                               DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                               DBColExpress.guide_voice <- (p["guide_voice"] as? String),
                                               DBColExpress.guide_voice_en <- (p["guide_voice_en"] as? String),
                                               DBColExpress.video <- (p["video"] as? String),
                                               DBColExpress.splash_bg_vertical <- (p["splash_bg_vertical"] as? String),
                                               DBColExpress.splash_fg_vertical <- (p["splash_fg_vertical"] as? String),
                                               DBColExpress.splash_blur_vertical <- (p["splash_blur_vertical"] as? String),
                                               DBColExpress.zone_id <- (p["zone_id"] as? String)
                        ))
                        }
                        
                    }
                }
            }
        }
        catch {
            print(error)
        }
        
    }
    
    func createdeviceTable() {
        
        let url = URL(string:DatabaseUtilizer.downloadURL + "?data=device")
        do{
            let db = try Connection(databaseFilePath)
            let device = Table("device")
            try db.run(device.create(ifNotExists: true) { t in
                t.column(DBColExpress.device_id)
                t.column(DBColExpress.name)
                t.column(DBColExpress.name_en)
                t.column(DBColExpress.introduction)
                t.column(DBColExpress.introduction_en)
                t.column(DBColExpress.photo)
                t.column(DBColExpress.photo_vertical)
                t.column(DBColExpress.mode_id)
                t.column(DBColExpress.company_id)
            })
            
            if let data = try? Data(contentsOf: url!){
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options:.allowFragments){
                    for p in jsonObj as! [[String: Any]]{
                        var p = p
                        /*if((p["introduction_en"] as? String)?.isEmpty)!{
                            p["introduction_en"] = ""
                        }*/
                        if((p["introduction_en"] as? String) == nil){
                            p["introduction_en"] = ""
                        }
                        if((p["photo"] as? String) == nil){
                            p["photo"] = ""
                        }
                        if((p["photo_vertical"] as? String) == nil){
                            p["photo_vertical"] = ""
                        }
                        let filtering = Table("device").filter(DBColExpress.device_id == p["device_id"] as? String)
                        let plucking = try db.pluck(filtering)
                        if (plucking != nil) {
                            try db.run(filtering.update(DBColExpress.device_id <- p["device_id"] as? String ,
                                                     DBColExpress.name <- (p["name"] as? String),
                                                     DBColExpress.name_en <- (p["name_en"] as? String),
                                                     DBColExpress.introduction <- (p["introduction"] as? String),
                                                     DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                                     DBColExpress.photo <- (p["photo"] as? String),
                                                     DBColExpress.photo_vertical <- (p["photo_vertical"] as? String),
                                                     DBColExpress.mode_id <- (p["mode_id"] as? String),
                                                     DBColExpress.company_id <- (p["company_id"] as? String)
                            ))
                        }
                        else{

                        try db.run(device.insert(DBColExpress.device_id <- p["device_id"] as? String ,
                                               DBColExpress.name <- (p["name"] as? String),
                                               DBColExpress.name_en <- (p["name_en"] as? String),
                                               DBColExpress.introduction <- (p["introduction"] as? String),
                                               DBColExpress.introduction_en <- (p["introduction_en"] as? String),
                                               DBColExpress.photo <- (p["photo"] as? String),
                                               DBColExpress.photo_vertical <- (p["photo_vertical"] as? String),
                                               DBColExpress.mode_id <- (p["mode_id"] as? String),
                                               DBColExpress.company_id <- (p["company_id"] as? String)
                        ))}
                        
                    }
                }
            }
        }
        catch {
            print(error)
        }
        
    }
    
    func createcompanyTable() {
        
        let url = URL(string:DatabaseUtilizer.downloadURL + "?data=company")
        do{
            let db = try Connection(databaseFilePath)
            let company = Table("company")
            try db.run(company.create(ifNotExists: true) { t in
                t.column(DBColExpress.company_id)
                t.column(DBColExpress.name)
                t.column(DBColExpress.name_en)
                t.column(DBColExpress.tel)
                t.column(DBColExpress.fax)
                t.column(DBColExpress.web)
                t.column(DBColExpress.qrcode)
            })
            
            if let data = try? Data(contentsOf: url!){
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options:.allowFragments){
                    for p in jsonObj as! [[String: Any]]{
                        var p = p
                        /*if((p["introduction_en"] as? String)?.isEmpty)!{
                         p["introduction_en"] = ""
                         }*/
                        
                        if((p["qrcode"] as? String) == nil){
                            p["qrcode"] = ""
                        }
                        if((p["tel"] as? String) == nil){
                            p["tel"] = ""
                        }
                        if((p["fax"] as? String) == nil){
                            p["fax"] = ""
                        }
                        let filtering = Table("company").filter(DBColExpress.company_id == p["company_id"] as? String)
                        let plucking = try db.pluck(filtering)
                        if (plucking != nil) {
                            try db.run(filtering.update(DBColExpress.company_id <- p["company_id"] as? String ,
                                                      DBColExpress.name <- (p["name"] as? String),
                                                      DBColExpress.name_en <- (p["name_en"] as? String),
                                                      DBColExpress.tel <- (p["tel"] as? String),
                                                      DBColExpress.fax <- (p["fax"] as? String),
                                                      DBColExpress.web <- (p["web"] as? String),
                                                      DBColExpress.qrcode <- (p["qrcode"] as? String)
                            ))
                        }
                        else{
                        try db.run(company.insert(DBColExpress.company_id <- p["company_id"] as? String ,
                                                 DBColExpress.name <- (p["name"] as? String),
                                                 DBColExpress.name_en <- (p["name_en"] as? String),
                                                 DBColExpress.tel <- (p["tel"] as? String),
                                                 DBColExpress.fax <- (p["fax"] as? String),
                                                 DBColExpress.web <- (p["web"] as? String),
                                                 DBColExpress.qrcode <- (p["qrcode"] as? String)
                        ))}
                        
                    }
                }
            }
        }
        catch {
            print(error)
        }
        
    }

    func queryzoneTable() -> Array<ZoneItem> {
        //let databaseFileName = "buildingcenterdb.sqlite"
        //let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
        //let zones = NSMutableArray()
        var zones: [ZoneItem] = []
        //var zones = [[String: String]]()
        //let zone_id = Expression<String>("zone_id")
        let zone_id = DBColExpress.zone_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let guide_voice = DBColExpress.guide_voice
        let guide_voice_en = DBColExpress.guide_voice_en
        let hint = DBColExpress.hint
        let photo = DBColExpress.photo
        let photo_vertical = DBColExpress.photo_vertical
        let field_id = DBColExpress.field_id
        //let modes = "modes"
        
        /*
         let name = Expression<String>("name")
         let name_en = Expression<String>("name_en")
         let introduction = Expression<String>("introduction")
         let introduction_en = Expression<String>("introduction_en")
         let guide_voice = Expression<String>("guide_voice")
         let guide_voice_en = Expression<String>("guide_voice_en")
         let hint = Expression<String>("hint")
         let photo = Expression<String>("photo")
         let photo_vertical = Expression<String>("photo_vertical")
         let field_id = Expression<String>("field_id")*/
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("zone")
            //var z = ZoneItem()
            for rows in try db.prepare(table) {
                let z = ZoneItem()
                
                
                /*var zone: [String] = []
                 zone.append(rows[zone_id])
                 zone.append(rows[name])
                 zone.append(rows[name_en])
                 zone.append(rows[introduction])
                 zone.append(rows[introduction_en])
                 zone.append(rows[guide_voice])
                 zone.append(rows[guide_voice_en])
                 zone.append(rows[hint])
                 zone.append(rows[photo])
                 zone.append(rows[photo_vertical])
                 zone.append(rows[field_id])
                 */
                z.zone_id = rows[zone_id]
                z.name = rows[name]
                z.name_en = rows[name_en]
                z.introduction = rows[introduction]
                z.introduction_en = rows[introduction_en]
                z.guide_voice = rows[guide_voice]
                z.guide_voice_en = rows[guide_voice_en]
                z.hint = rows[hint]
                z.photo = rows[photo]
                z.photo_vertical = rows[photo_vertical]
                z.field_id = rows[field_id]
                z.modes = querymodeTable(zoneID:rows[zone_id]!)
                
                //print(rows[zone_id])
                //let data = ZoneItem(zone_id: rows[zone_id], name: rows[name], introduction: rows[introduction])
                //zones.append(zone)
                zones.append(z)
            }
        } catch _ {
            print("error")
        }
        return zones
    }


    
    func queryzoneTable(zoneID: String) -> ZoneItem {
        var zones = ZoneItem()
        let zone_id = DBColExpress.zone_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let guide_voice = DBColExpress.guide_voice
        let guide_voice_en = DBColExpress.guide_voice_en
        let hint = DBColExpress.hint
        let photo = DBColExpress.photo
        let photo_vertical = DBColExpress.photo_vertical
        let field_id = DBColExpress.field_id
        //let modes = "modes"
        
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("zone")
            //var z = ZoneItem()
            let filtering = table.filter(DBColExpress.zone_id.like(zoneID))
            for rows in try db.prepare(filtering) {
                let z = ZoneItem()
                
                z.zone_id = rows[zone_id]
                z.name = rows[name]
                z.name_en = rows[name_en]
                z.introduction = rows[introduction]
                z.introduction_en = rows[introduction_en]
                z.guide_voice = rows[guide_voice]
                z.guide_voice_en = rows[guide_voice_en]
                z.hint = rows[hint]
                z.photo = rows[photo]
                z.photo_vertical = rows[photo_vertical]
                z.field_id = rows[field_id]
                z.modes = querymodeTable(zoneID:rows[zone_id]!)
                zones = z
            }
        } catch _ {
            print("error")
        }
        return zones
    }
    
    func querymodeTable() -> Array<ModeItem> {
        
        var modes: [ModeItem] = []

        let mode_id = DBColExpress.mode_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let guide_voice = DBColExpress.guide_voice
        let guide_voice_en = DBColExpress.guide_voice_en
        let video = DBColExpress.video
        let splash_bg_vertical = DBColExpress.splash_bg_vertical
        let splash_fg_vertical = DBColExpress.splash_fg_vertical
        let splash_blur_vertical = DBColExpress.splash_blur_vertical
        let zone_id = DBColExpress.zone_id
        
        
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("mode")
            //var z = ZoneItem()
            for rows in try db.prepare(table) {
                let m = ModeItem()
                m.mode_id = rows[mode_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.introduction = rows[introduction]
                m.introduction_en = rows[introduction_en]
                m.guide_voice = rows[guide_voice]
                m.guide_voice_en = rows[guide_voice_en]
                m.video = rows[video]
                m.splash_bg_vertical = rows[splash_bg_vertical]
                m.splash_fg_vertical = rows[splash_fg_vertical]
                m.splash_blur_vertical = rows[splash_blur_vertical]
                m.zone_id = rows[zone_id]
                m.devices = querydeviceTable(modeID: rows[mode_id]!)
                //print(rows[zone_id])
                modes.append(m)
            }
        } catch _ {
            print("error")
        }
        return modes
    }
    
    func querymodeTable(zoneID: String) -> Array<ModeItem> {
        
        var modes: [ModeItem] = []
        let mode_id = DBColExpress.mode_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let guide_voice = DBColExpress.guide_voice
        let guide_voice_en = DBColExpress.guide_voice_en
        let video = DBColExpress.video
        let splash_bg_vertical = DBColExpress.splash_bg_vertical
        let splash_fg_vertical = DBColExpress.splash_fg_vertical
        let splash_blur_vertical = DBColExpress.splash_blur_vertical
        let zone_id = DBColExpress.zone_id
       
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("mode")
            let filtering = table.filter(DBColExpress.zone_id.like(zoneID))
            for rows in try db.prepare(filtering) {
                let m = ModeItem()
                m.mode_id = rows[mode_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.introduction = rows[introduction]
                m.introduction_en = rows[introduction_en]
                m.guide_voice = rows[guide_voice]
                m.guide_voice_en = rows[guide_voice_en]
                m.video = rows[video]
                m.splash_bg_vertical = rows[splash_bg_vertical]
                m.splash_fg_vertical = rows[splash_fg_vertical]
                m.splash_blur_vertical = rows[splash_blur_vertical]
                m.zone_id = rows[zone_id]
                m.devices = querydeviceTable(modeID: rows[mode_id]!)
                //print(rows[zone_id])
                modes.append(m)
            }
        } catch _ {
            print("error")
        }
        return modes
    }

    
    func querydeviceTable() -> Array<DeviceItem> {
        
        var devices: [DeviceItem] = []
        
        let device_id = DBColExpress.mode_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let photo = DBColExpress.photo
        let photo_vertical = DBColExpress.photo_vertical
        let mode_id = DBColExpress.mode_id
        let company_id = DBColExpress.company_id
        
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("device")
            //var z = ZoneItem()
            for rows in try db.prepare(table) {
                let m = DeviceItem()
                m.device_id = rows[device_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.introduction = rows[introduction]
                m.introduction_en = rows[introduction_en]
                m.photo = rows[photo]
                m.photo_vertical = rows[photo_vertical]
                m.mode_id = rows[mode_id]
                m.company_id = rows[company_id]
                
                //print(rows[zone_id])
                //let data = ZoneItem(zone_id: rows[zone_id], name: rows[name], introduction: rows[introduction])
                //zones.append(zone)
                devices.append(m)
            }
        } catch _ {
            print("error")
        }
        return devices
    }
    
    func querydeviceTable(modeID: String) -> Array<DeviceItem> {
        
        var devices: [DeviceItem] = []
        
        let device_id = DBColExpress.mode_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let introduction = DBColExpress.introduction
        let introduction_en = DBColExpress.introduction_en
        let photo = DBColExpress.photo
        let photo_vertical = DBColExpress.photo_vertical
        let mode_id = DBColExpress.mode_id
        let company_id = DBColExpress.company_id
        
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("device")
            //var z = ZoneItem()
            let filtering = table.filter(DBColExpress.mode_id.like(modeID))
            for rows in try db.prepare(filtering) {
                let m = DeviceItem()
                m.device_id = rows[device_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.introduction = rows[introduction]
                m.introduction_en = rows[introduction_en]
                m.photo = rows[photo]
                m.photo_vertical = rows[photo_vertical]
                m.mode_id = rows[mode_id]
                m.company_id = rows[company_id]
                //m.companys = querycompanyTable(companyID: rows[company_id]! as String)
                m.companys = querycompanyTable(companyID: rows[company_id]!)
                devices.append(m)
            }
        } catch _ {
            print("error")
        }
        return devices
    }


    func querycompanyTable() -> Array<CompanyItem> {
        var companys: [CompanyItem] = []
        
        let company_id = DBColExpress.company_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let tel = DBColExpress.tel
        let fax = DBColExpress.fax
        let web = DBColExpress.web
        let qrcode = DBColExpress.qrcode

        do {
            let db = try Connection(databaseFilePath)
            let table = Table("company")
            for rows in try db.prepare(table) {
                let m = CompanyItem()
                m.company_id = rows[company_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.tel = rows[tel]
                m.fax = rows[fax]
                m.web = rows[web]
                m.qrcode = rows[qrcode]
                
                companys.append(m)
            }
        } catch _ {
            print("error")
        }
        return companys
    }
    
    func querycompanyTable(companyID: String) -> CompanyItem {
        //var companys: [CompanyItem] = []
        var companys =  CompanyItem()
        let company_id = DBColExpress.company_id
        let name = DBColExpress.name
        let name_en = DBColExpress.name_en
        let tel = DBColExpress.tel
        let fax = DBColExpress.fax
        let web = DBColExpress.web
        let qrcode = DBColExpress.qrcode
        
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("company")
            let filtering = table.filter(DBColExpress.company_id.like(companyID))
            let m = CompanyItem()
            
            for rows in try db.prepare(filtering) {
                //let m = CompanyItem()
                m.company_id = rows[company_id]
                m.name = rows[name]
                m.name_en = rows[name_en]
                m.tel = rows[tel]
                m.fax = rows[fax]
                m.web = rows[web]
                m.qrcode = rows[qrcode]
                companys = m
                return m
                //break
                //companys.append(m)
            }
            
        } catch _ {
            print("error")
        }
        return companys
    }

    
    
}
