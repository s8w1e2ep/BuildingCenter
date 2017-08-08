//
//  MainPageViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 08/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var hipsterButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    
    @IBOutlet weak var mainContainerView: UIView!
    var mapNavigationController: UINavigationController!
    var hipsterViewController: HipsterViewController!

    var selectedViewController: UIViewController!
    var selectedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hipsterViewController = (self.storyboard?.instantiateViewController(withIdentifier: "HipsterViewController"))! as! HipsterViewController
        
        selectedViewController = mapNavigationController
        selectedButton = mapButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onMapClick(_ sender: UIButton) {
        changeTab(to: mapButton)
        changePage(to: mapNavigationController)
    }
    @IBAction func onHipsterClick(_ sender: UIButton) {
        changeTab(to: hipsterButton)
        changePage(to: hipsterViewController)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerViewSegue" {
            mapNavigationController = segue.destination as! UINavigationController
        }
    }
    
    func changePage(to newViewController: UIViewController) {
        // Remove previous viewController
        selectedViewController.willMove(toParentViewController: nil)
        selectedViewController.view.removeFromSuperview()
        selectedViewController.removeFromParentViewController()
        
        // Add new viewController
        addChildViewController(newViewController)
        self.mainContainerView.addSubview(newViewController.view)
        newViewController.view.frame = mainContainerView.bounds
        newViewController.didMove(toParentViewController: self)
        
        self.selectedViewController = newViewController
    }
    func changeTab(to newButton: UIButton){
        selectedButton.isSelected = false
        
        newButton.isSelected = true
        
        self.selectedButton = newButton

    }
}
