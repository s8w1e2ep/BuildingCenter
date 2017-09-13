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
    
    var modeItem: ModeItem!
    var equipmentNumber: Int = 0
    var isShowed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLayout()
        setVideo()
        setText()
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setLayout(){
        let path = modeItem.devices?[equipmentNumber].photo_vertical
        let index = path?.index((path?.startIndex)!, offsetBy: 3)
        let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
        image.downloadedFrom(link: imageName)
    }
    func setVideo() {
        
        var videoPtah = modeItem.video
        videoView.allowsInlineMediaPlayback = true
        videoPtah = videoPtah?.replacingOccurrences(of: "watch?v=", with: "embed/")
        
        videoView.loadHTMLString("<iframe width=\"\(videoView.frame.width)\" height=\"\(videoView.frame.height)\" src=\"\(videoPtah!)"+"?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
    func setText() {
        if BeginViewController.isEnglish {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name_en
            textView.text = modeItem.devices?[equipmentNumber].introduction_en
        }else {
            equipmentTitle.text = modeItem.devices?[equipmentNumber].name
            textView.text = modeItem.devices?[equipmentNumber].introduction
        }
        
    }
    
    

}
