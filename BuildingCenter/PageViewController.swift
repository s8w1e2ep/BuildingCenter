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
    
    lazy var page1ViewController: ModeContentDetailViewController = (self.storyboard?.instantiateViewController(withIdentifier: "Page1"))! as! ModeContentDetailViewController
    lazy var page2ViewController: ModeContentDetailViewController2 = (self.storyboard?.instantiateViewController(withIdentifier: "Page2"))! as! ModeContentDetailViewController2
    
    lazy var firmInfoViewController: FirmInfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FirmInfo"))! as! FirmInfoViewController
    
    lazy var orderedViewControllers: [UIViewController] = {
        [self.page1ViewController, self.page2ViewController]
    }()
    
    var mainViewController: ModeContentViewController!
    var willTransitionTo: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        setViewControllers([page1ViewController], direction: .forward, animated: false, completion: nil)
        
        setNotification()
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
        
        //UIView.transition(with: self.page1ViewController.view, duration: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations:{self.view.}, completion: nil)
        if (noti.userInfo!["isAdded"] as! Int == 0) {
            self.page1ViewController.view.addSubview(self.firmInfoViewController.view)
        }else {
            self.firmInfoViewController.view.removeFromSuperview()
            
        }
    }

        
    func showPage(byIndex index: Int) {
        let viewController = orderedViewControllers[index]
        setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 && previousIndex < orderedViewControllers.count else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else {
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
    
    @objc(pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:) func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers previousVieControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let index = orderedViewControllers.index(of: self.willTransitionTo) else { return }
            let previousViewController = previousVieControllers.first!
            let previousIndex = orderedViewControllers.index(of: previousViewController)
            if index != previousIndex {
                mainViewController.changeTab(byIndex: index)
            }
        }
    }
}
