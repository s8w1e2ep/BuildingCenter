//
//  MapInstructionViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 19/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class MapInstructionViewController: UIViewController {
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var mapGuide: UILabel!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var tourRoute: UILabel!
    @IBOutlet weak var visitedLocation: UILabel!
    @IBOutlet weak var unvisitedLocation: UILabel!
    @IBOutlet weak var nextLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setTapAction()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    func setTapAction() {
        tap.addTarget(self, action: #selector(MapInstructionViewController.dismissViewController))
    }
    func setText(selectLanguage: String) {
        // according to language set text
        
        mapGuide.text = "mapguide_title".localized(language: selectLanguage)
        currentLocation.text = "mapguide_now".localized(language: selectLanguage)
        tourRoute.text = "mapguide_tour".localized(language: selectLanguage)
        visitedLocation.text = "mapguide_visited".localized(language: selectLanguage)
        unvisitedLocation.text = "mapguide_unvisited".localized(language: selectLanguage)
        nextLocation.text = "mapguide_next_visited".localized(language: selectLanguage)
        
    }
}
