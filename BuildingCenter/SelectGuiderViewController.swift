//
//  SelectGuiderViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/18.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class SelectGuiderViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var navbar: UINavigationBar!
    
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
        scrollImg.contentSize = CGSize(width: self.view.frame.size.width * 2.35, height: self.view.frame.size.height * 0.6)
        scrollImg.contentOffset = CGPoint(x: self.view.frame.size.width * 0.65, y: 0)
        // scrollImg.contentInset = UIEdgeInsetsMake(0.0, 0.0, 80.0, 0.0)
        
        let xList = [(self.view.frame.size.width * 0.1), (self.view.frame.size.width * 0.8), (self.view.frame.size.width * 1.5)]
        
        for index in 1...3 {
            let image = UIImage(named: imgList[index - 1])
            //let x = CGFloat(index - 1) * self.view.frame.size.width
            let imageView = UIImageView(frame: CGRect(x: xList[index - 1], y: 0, width: self.view.frame.size.width * 0.7, height: self.view.frame.size.height * 0.6))
            imageView.image = image
            scrollImg.addSubview(imageView)
        }
        //src.showsHorizontalScrollIndicator = false
        //src.showsVerticalScrollIndicator = false
        //src.isPagingEnabled = true
        //src.bounces = false
        let navBackgroundImage:UIImage! = UIImage(named: "tour_select_background.png")
        self.navbar.setBackgroundImage(navBackgroundImage, for: .default)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
