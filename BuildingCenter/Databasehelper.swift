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
    func deletezonetable(){
        do{
            let db = try Connection(databaseFilePath)
            let zone = Table("zone")
            try db.run(zone.drop(ifExists: true))
        }catch {
            print(error)
        }
    }
    
    func surveyupload(stringUrl: String){
        //let stringUrl = "http://192.168.65.28/interface/survey.php?survey={\"gender\":\"1\",\"age\":\"3\"}"
        if let encodedURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURL) {
            let url2 = NSURL(string: encodedURL)
            
            do{
             let html = try String(contentsOf: url2! as URL)
             print(html)
             }catch{
             print(error)
             }
        }
        
    }
    
    func createzoneTable() {
        let zone_id = Expression<String?>("zone_id")
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
        
        //let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
        //let db = try Connection(databaseFilePath)
        let url = URL(string: "http://192.168.65.28/interface/getfile.php?data=zone")
        
        do{
            let db = try Connection(databaseFilePath)
            let zone = Table("zone")
            try db.run(zone.create { t in
                t.column(zone_id)
                t.column(name)
                t.column(name_en)
                t.column(introduction)
                t.column(introduction_en)
                t.column(guide_voice)
                t.column(guide_voice_en)
                t.column(hint)
                t.column(photo)
                t.column(photo_vertical)
                t.column(field_id)
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
                        try db.run(zone.insert(zone_id <- p["zone_id"] as? String ,
                                               name <- (p["name"] as? String),
                                               name_en <- (p["name_en"] as? String),
                                               introduction <- (p["introduction"] as? String),
                                            introduction_en <- (p["introduction_en"] as? String),
                                            guide_voice <- (p["guide_voice"] as? String),
                                            guide_voice_en <- (p["guide_voice_en"] as? String),
                                            hint <- (p["hint"] as? String),
                                            photo <- (p["photo"] as? String),
                                            photo_vertical <- (p["photo_vertical"] as? String),
                                            field_id <- (p["field_id"] as? String)
                        ))
                        
                    }
                }
            }
        }
        catch {
            print(error)
        }
        
    }
    
    func queryzoneTable() -> Array<Any> {
        //let databaseFileName = "buildingcenterdb.sqlite"
        //let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
        //let zones = NSMutableArray()
        var zones: [ZoneItem] = []
        //var zones = [[String: String]]()
        let zone_id = Expression<String>("zone_id")
        let name = Expression<String>("name")
        let name_en = Expression<String>("name_en")
        let introduction = Expression<String>("introduction")
        let introduction_en = Expression<String>("introduction_en")
        let guide_voice = Expression<String>("guide_voice")
        let guide_voice_en = Expression<String>("guide_voice_en")
        let hint = Expression<String>("hint")
        let photo = Expression<String>("photo")
        let photo_vertical = Expression<String>("photo_vertical")
        let field_id = Expression<String>("field_id")
        do {
            let db = try Connection(databaseFilePath)
            let table = Table("zone")
            //var z = ZoneItem()
            for rows in try db.prepare(table) {
                var z = ZoneItem()
                
                
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


}
