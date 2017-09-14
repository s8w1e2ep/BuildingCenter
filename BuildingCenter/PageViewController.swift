//
//  PageViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 05/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    
    let notificationFirmClicked = Notification.Name("firmClickedNoti")
    let notificationPageChanged = Notification.Name("pageChangededNoti")

    var orderedViewControllers = [ModeContentDetailViewController]()
    var firmInfoViewControllers = [FirmInfoViewController]()
    
    var mainViewController: ModeContentViewController!
    var willTransitionTo: UIViewController!
    
    var modeItem: ModeItem!
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        if modeItem.video == "" {
            for index in 0 ... (modeItem.devices?.count)!-1 {
                let page = (self.storyboard?.instantiateViewController(withIdentifier: "Page2"))! as! ModeContentDetailViewController2
                page.equipmentNumber = index
                page.modeItem = modeItem
                orderedViewControllers.append(page)
            }
            
        }else {
            for index in 0 ... (modeItem.devices?.count)!-1 {
                let page = (self.storyboard?.instantiateViewController(withIdentifier: "Page1"))! as! ModeContentDetailViewController
                page.equipmentNumber = index
                page.modeItem = modeItem
                orderedViewControllers.append(page)
                
        }
        }
        for index in 0 ... (modeItem.devices?.count)!-1 {
            let firmInfo = (self.storyboard?.instantiateViewController(withIdentifier: "FirmInfo"))! as! FirmInfoViewController
            firmInfo.equipmentNumber = index
            firmInfo.modeItem = modeItem
            firmInfoViewControllers.append(firmInfo)
        }
        
        setViewControllers([orderedViewControllers[0]], direction: .forward, animated: false, completion: nil)
        
        setNotification()
        
        NotificationCenter.default.post(name: notificationPageChanged, object: nil, userInfo: ["TTS":orderedViewControllers[currentIndex].TTS])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    */
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(firmClickedNoti(noti:)), name: notificationFirmClicked, object: nil)
        
    }
    func firmClickedNoti(noti:Notification) {
        
        //
        if (noti.userInfo!["isAdded"] as! Int == 0) {
            //self.page1ViewController.view.addSubview(self.firmInfoViewController.view)
            UIView.transition(with: self.orderedViewControllers[currentIndex].view, duration: 0.5, options: UIViewAnimationOptions.transitionCurlDown, animations:{self.orderedViewControllers[self.currentIndex].view.addSubview(self.firmInfoViewControllers[self.currentIndex].view)}, completion: nil)
            orderedViewControllers[currentIndex].isShowed = true
        }else {
            UIView.transition(with: self.orderedViewControllers[currentIndex].view, duration: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations:{self.firmInfoViewControllers[self.currentIndex].view.removeFromSuperview()}, completion: nil)
            orderedViewControllers[currentIndex].isShowed = false
        }
    }
    
        
    func showPage(byIndex index: Int) {
        let viewController = orderedViewControllers[index]
        setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
        currentIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController as! ModeContentDetailViewController) else {
            return nil
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 && previousIndex < orderedViewControllers.count else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController as! ModeContentDetailViewController) else {
            return nil
        }
        let nextIndex = index + 1
        guard nextIndex >= 0 && nextIndex < orderedViewControllers.count else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.willTransitionTo = pendingViewControllers.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers previousVieControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let index = orderedViewControllers.index(of: self.willTransitionTo as! ModeContentDetailViewController) else { return }
            let previousViewController = previousVieControllers.first! as! ModeContentDetailViewController
            let previousIndex = orderedViewControllers.index(of: previousViewController )
            if index != previousIndex {
                mainViewController.changeTab(byIndex: index)
                currentIndex = index
            }
            NotificationCenter.default.post(name: notificationPageChanged, object: nil, userInfo: ["TTS":orderedViewControllers[currentIndex].TTS])
            if previousViewController.isShowed {
                UIView.transition(with: self.orderedViewControllers[previousIndex!].view, duration: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations:{self.firmInfoViewControllers[previousIndex!].view.removeFromSuperview()}, completion: nil)
            }
        }
    }
}
