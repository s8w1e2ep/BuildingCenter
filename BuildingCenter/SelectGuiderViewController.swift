//
//  SelectGuiderViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/18.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class SelectGuiderViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollImg: UIScrollView!
    var page: UIPageControl! = nil
    var timer: Timer! = nil
    let imgList = [
        "tour_select_designer.png",
        "tour_select_robot.png",
        "tour_select_housekeeper.png"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().barTintColor = UIColor(red: 85, green: 86, blue: 86, alpha: 1)
        
        //let src = UIScrollView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.6))
        //scrollImg = src
        //scrollImg.delegate = self
        scrollImg.contentSize = CGSize(width: self.view.frame.size.width * 3, height: 300)
        //self.view.addSubview(scrollImg)
        
        for index in 1...3 {
            let image = UIImage(named: imgList[index - 1])
            let x = CGFloat(index - 1) * self.view.frame.size.width
            let imageView = UIImageView(frame: CGRect(x: x + self.view.frame.size.width * 0.1, y: 0, width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.6))
            imageView.image = image
            scrollImg.addSubview(imageView)
        }
        //src.showsHorizontalScrollIndicator = false
        //src.showsVerticalScrollIndicator = false
        //src.isPagingEnabled = true
        //src.bounces = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
