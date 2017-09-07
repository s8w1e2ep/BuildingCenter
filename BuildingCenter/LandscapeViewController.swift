//
//  LandscapeViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//


import UIKit

class LandscapeViewController: UIViewController {
    
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var markImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut, .repeat, .autoreverse], animations: { self.highlightImage.alpha = 1 }, completion: {_ in self.markImage.isHidden = false })
        DispatchQueue.main.asyncAfter(deadline: (.now()+1.5), execute: {
            self.highlightImage.layer.removeAllAnimations()
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
    }
    
}
