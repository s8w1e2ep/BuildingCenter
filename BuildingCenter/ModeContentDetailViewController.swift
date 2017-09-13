//
//  ModeContentDetailViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 05/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeContentDetailViewController: UIViewController {
    
    
    @IBOutlet weak var equipmentTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var viewControl: UISegmentedControl!
    @IBOutlet var videoView: UIWebView!
    
    var equipmentNumber: Int = 0
    var isShowed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        equipmentTitle.text = equipmentTitle.text!+"\(equipmentNumber+1)"
        image.image = UIImage(named: "a1m\(equipmentNumber+1)_bg")
        textView.text = textView.text + "\(equipmentNumber+1)"

        videoView.allowsInlineMediaPlayback = true
        videoView.loadHTMLString("<iframe width=\"\(videoView.frame.width)\" height=\"\(videoView.frame.height)\" src=\"https://www.youtube.com/embed/7LnSBroCaPA?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
        
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        if viewControl.selectedSegmentIndex == 0
        {
            videoView.isHidden = false
            image.isHidden = true
        }
        
        if viewControl.selectedSegmentIndex == 1
        {
            videoView.isHidden = true
            image.isHidden = false
        }
        
        
        
    }
    
    
    
/*
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: notificationEnterModeContent, object: nil, userInfo: ["TTS":textView.text])
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: notificationExitModeContent, object: nil, userInfo: ["TTS":textView.text])
    }
  */  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp(number:Int) {
        equipmentTitle.text = equipmentTitle.text!+"\(number)"
        image.image = UIImage(named: "a1m\(number)_bg")
        textView.text = textView.text + "\(number)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
    

}
