//
//  SelectGuiderViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/18.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class SelectGuiderViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var confirm: UIButton!
    
    let databaseHelper = Databasehelper()
    
    
    var courses = [
        ["name":"設計師","pic":"tour_select_designer.png"],
        ["name":"機器人","pic":"tour_select_robot.png"],
        ["name":"管家","pic":"tour_select_housekeeper.png"]
    ]
    let pageCutRate:CGFloat = 0.1
    var currentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setLayout()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if (databaseHelper.queryhintTable().guider == "0") {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "GuiderHint"){
                present(vc, animated: true)
            }
            databaseHelper.read_guider()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        self.performSegue(withIdentifier: "toNext", sender: self);
    }

    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "tour_select_background.png")
        self.navBar.setBackgroundImage(navBackgroundImage, for: .default)
        
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(
            width: CGFloat(self.view.bounds.width) * (1-pageCutRate*2) * CGFloat(self.courses.count),
            height: scrollView.bounds.size.height
        )
        let size = scrollView.bounds.size
        
        for (seq,course) in courses.enumerated() {
            let page = UIView()
            page.frame = CGRect(x: CGFloat(seq) * size.width * (1-pageCutRate*2), y: 0,
                                width: size.width * (1-pageCutRate*2), height: size.height)
            page.backgroundColor = UIColor.clear
            
            let imageView = UIImageView(image: UIImage(named: course["pic"]!))
            imageView.frame = CGRect(x: size.width * (-0.5*pageCutRate), y: 0, width: size.width * (1-pageCutRate*1), height: size.height)
            
            let label = UILabel(frame: CGRect(x: 0, y: size.height*0.83, width: size.width * (1-pageCutRate*2), height: 20))
            label.text = course["name"]
            label.textAlignment = .center
            label.textColor = UIColor.white
            //label.font = UIFont(name: "Helvetica-Light", size: 24)
            label.font = label.font.withSize(25)
            
            page.addSubview(imageView)
            page.addSubview(label)
            scrollView.addSubview(page)
        }
        scrollView.contentOffset.x = CGFloat(currentIndex) * scrollView.bounds.width * (1-3*pageCutRate)

        
    }
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "tour_title".localized(language: selectLanguage)

        courses = [
            ["name":"tour_select_designer".localized(language: selectLanguage),"pic":"tour_select_designer.png"],
            ["name":"tour_select_robot".localized(language: selectLanguage),"pic":"tour_select_robot.png"],
            ["name":"tour_select_housekeeper".localized(language: selectLanguage),"pic":"tour_select_housekeeper.png"]
        ]
        confirm.setTitle("confirm".localized(language: selectLanguage), for: .normal)
    }


    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        let maxIndex = CGFloat(courses.count)
        let tarX = scrollView.contentOffset.x + velocity.x * 80
        var tarIndex = round(tarX / (scrollView.bounds.width * (1-3*pageCutRate)))
        if tarIndex < 0 {
            tarIndex = 0
        }
        if tarIndex > maxIndex {
            tarIndex = maxIndex
        }
        targetContentOffset.pointee.x = tarIndex * scrollView.bounds.width * (1-3*pageCutRate)
        currentIndex = Int(tarIndex)
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
