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
    
    //@IBOutlet weak var scrollImg: UIScrollView!
    @IBOutlet weak var imgTour: UIImageView!
    @IBOutlet weak var lbTour: UILabel!
    @IBOutlet weak var pcTour: UIPageControl!
    
    let imgList = [
        "tour_select_designer.png",
        "tour_select_robot.png",
        "tour_select_housekeeper.png"
    ]
    
    let nameList = [
        "設計師", "機器人", "管家"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pcTour.isHidden = true
        
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "tour_select_background.png")
        self.navbar.setBackgroundImage(navBackgroundImage, for: .default)
        
        // swift left
        let swipeLeft = UISwipeGestureRecognizer(
            target:self,
            action:#selector(self.swipe(recognizer:)))
        swipeLeft.direction = .left
        
        // swift right
        let swipeRight = UISwipeGestureRecognizer(
            target:self,
            action:#selector(self.swipe(recognizer:)))
        swipeRight.direction = .right
        
        // add gesture event into view
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isGuiderLaunchBefore = defaults.bool(forKey: "isGuiderLaunchBefore")
        
        if (!isGuiderLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "GuiderHint"){
                //show(vc, sender: self)
                present(vc, animated: true)
            }
            defaults.set(true, forKey: "isGuiderLaunchBefore")
        }
    }

    // gesture event function
    func swipe(recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            pcTour.currentPage = (self.pcTour.currentPage + 1) % 3
        } else if recognizer.direction == .right {
            pcTour.currentPage = (self.pcTour.currentPage + 2) % 3
        }
        imgTour.image = UIImage(named: imgList[pcTour.currentPage])
        lbTour.text = nameList[pcTour.currentPage]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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
