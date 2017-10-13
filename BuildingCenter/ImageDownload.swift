//
//  ImageDownload.swift
//  BuildingCenter
//
//  Created by uscc on 2017/9/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation
import UIKit

class ImageDownload{
    
    /*func downloadimg(){
        let path = zoneItem.modes![indexPath.item].splash_bg_vertical
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        //cell.backImage.downloadedFrom(link: imageName)
    }*/
    
    func showpic(image:UIImageView,url:String){
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let splitarray = url.components(separatedBy: "/")
        var pathname = "a1m4_bg@2x.png"
        for i in splitarray{
            pathname = i
        }
        if let dirPath = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(pathname)
            image.image    = UIImage(contentsOfFile: imageURL.path)
        }
        
    }

    
    func sessionSimpleDownload(urlpath:String){
        //下载地址
        let url = URL(string: urlpath)
        //请求
        let request = URLRequest(url: url!)
        //let config = URLSessionConfiguration.background(withIdentifier: "")
        let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120.0
        //print(sessionConfig.timeoutIntervalForResource)
        //let session = URLSession(configuration: sessionConfig)
        //let session = URLSession(configuration:config,delegate:seif,delegateQueue:nil)
        //下载任务
        let splitarray = urlpath.components(separatedBy: "/")
        var pathname = "1.png"
        for i in splitarray{
            pathname = i
        }
        //print(pathname)
        let documnets:String = NSHomeDirectory() + "/Documents/"+pathname
        let fileManager = FileManager.default
        if(!FileManager.default.fileExists(atPath: documnets)){
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    //print("Successfully downloaded. Status code: \(statusCode)")
                    print(pathname)
                }
                
                do {
                    //try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    if(tempLocalUrl.path != nil){
                        let locationPath = tempLocalUrl.path
                        //拷贝到用户目录
                        let documnets:String = NSHomeDirectory() + "/Documents/"+pathname
                        //创建文件管理器
                        //let fileManager = FileManager.default
                        
                        if(!FileManager.default.fileExists(atPath: documnets)){
                            try! fileManager.moveItem(atPath: locationPath, toPath: documnets)}}
                } catch (let writeError) {
                    print("Error")
                }
            
            } else {
                print(error?.localizedDescription);
            }
        }
        task.resume()
        }
        else{
            print("already exist"+pathname)
        }
        
        /*
        let downloadTask = session.downloadTask(with: request,
                                                completionHandler: { (location:URL?, response:URLResponse?, error:Error?)
                                                    -> Void in
                                                    //输出下载文件原来的存放目录
                                                    //print("location:\(location)")
                                                    //location位置转换
                                                    if(location?.path != nil){
                                                    let locationPath = location!.path
                                                    //拷贝到用户目录
                                                    let documnets:String = NSHomeDirectory() + "/Documents/"+pathname
                                                    //创建文件管理器
                                                    let fileManager = FileManager.default
                                                    
                                                    if(!FileManager.default.fileExists(atPath: documnets)){
                                                        try! fileManager.moveItem(atPath: locationPath, toPath: documnets)}}
                                                    //print("new location:\(documnets)")
        })

        downloadTask.resume()*/
    }
    
}
