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
    
    var equipmentNumber: Int = 0
    var isShowed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        equipmentTitle.text = equipmentTitle.text!+"\(equipmentNumber+1)"
        image.image = UIImage(named: "a1m\(equipmentNumber+1)_bg")
        textView.text = textView.text + "\(equipmentNumber+1)"

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
