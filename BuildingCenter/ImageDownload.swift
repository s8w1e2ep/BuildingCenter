//
//  ImageDownload.swift
//  BuildingCenter
//
//  Created by uscc on 2017/9/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation
import UIKit

class ImageDownload:NSObject,URLSessionDownloadDelegate{
    
    func showpic(image:UIImageView,url:String){
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(url)
            image.image    = UIImage(contentsOfFile: imageURL.path)
        }
        
    }
    
    func sessionSimpleDownload(urlpath:String){
        //下载地址
        let url = URL(string: urlpath)
        //请求
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        //下载任务
        let splitarray = urlpath.components(separatedBy: "/")
        var pathname = "1.png"
        for i in splitarray{
            pathname = i
        }
        let downloadTask = session.downloadTask(with: request,
                                                completionHandler: { (location:URL?, response:URLResponse?, error:Error?)
                                                    -> Void in
                                                    //输出下载文件原来的存放目录
                                                    print("location:\(location)")
                                                    //location位置转换
                                                    let locationPath = location!.path
                                                    //拷贝到用户目录
                                                    let documnets:String = NSHomeDirectory() + "/Documents/"+pathname
                                                    //创建文件管理器
                                                    let fileManager = FileManager.default
                                                    try! fileManager.moveItem(atPath: locationPath, toPath: documnets)
                                                    print("new location:\(documnets)")
        })
        
        //使用resume方法启动任务
        downloadTask.resume()
    }
    
    func getpic(url : String){
        let url = URL(string:url)
        let config = URLSessionConfiguration.background(withIdentifier: "abc")
        let session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let dnTask = session.downloadTask(with: url!)
        dnTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        /*if let data = try?Data(contentsOf:location){
         //print(location)
         DispatchQueue.main.async(execute:{
         self.img.image = UIImage(data:data)
         })
         }*/
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if error == nil{
            print("suss")
        }else{
            print("fail")
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("done")
    }
}
