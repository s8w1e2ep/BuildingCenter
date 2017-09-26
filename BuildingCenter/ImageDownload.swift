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
        let url = URL(string: url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!);             DispatchQueue.main.async {
                image.image = UIImage(data: data!)
            }
        }    }
    
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
