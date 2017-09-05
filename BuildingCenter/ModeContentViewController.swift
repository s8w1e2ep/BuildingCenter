//
//  ModeContentViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        firstView.isHidden = false
        secondView.isHidden = true
        segmentControl.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isModeContentLaunchBefore = defaults.bool(forKey: "isModeContentLaunchBefore")
        
        if (!isModeContentLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ModeContentHint"){
                //show(vc, sender: self)
                present(vc, animated: true)
                
            }
            defaults.set(true, forKey: "isModeContentLaunchBefore")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    @IBAction func slideRight(_ sender: Any)
    {
        let index = (segmentControl.selectedSegmentIndex == 0) ? 0 : segmentControl.selectedSegmentIndex-1
        segmentControl.selectedSegmentIndex = index
        changePage()
    }
    @IBAction func slideLeft(_ sender: Any)
    {
        let index = (segmentControl.selectedSegmentIndex == segmentControl.numberOfSegments-1
                ) ? segmentControl.numberOfSegments-1 : segmentControl.selectedSegmentIndex+1
        segmentControl.selectedSegmentIndex = index
        changePage()
    }

    
    @IBAction func indexChanged(_ sender: Any) {
        changePage()
    }
    func changePage()
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            firstView.isHidden = false
            secondView.isHidden = true
        case 1:
            firstView.isHidden = true
            secondView.isHidden = false
        default:
            break;
        }
    
    }
}
