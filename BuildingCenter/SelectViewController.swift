//
//  SelectViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/7/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var index = 0
    var image: UIImage!
    var template: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }

    @IBAction func nextButtononClick(_ sender: Any) {
        template = #imageLiteral(resourceName: "template_1")
        self.performSegue(withIdentifier: "selectToWriting", sender: self)
    }
    
    func combine(leftImage: UIImage, rightImage: UIImage) -> UIImage {
        let width = leftImage.size.width
        let height = leftImage.size.height + rightImage.size.height
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        var x = 0;
        var y = 0;
        if(index % 2 == 1){
            x = 10;
            y = 10;
        }
        else{
            x = 10;
            y = 10;
        }
        leftImage.draw(at: CGPoint(x: 0, y: 0))
        rightImage.draw(at: CGPoint(x: x, y: y))
        let imageLong = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageLong!
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagimage = image
        let tagtemplate = template
        let controller = segue.destination as! WritingViewController
        controller.image = tagimage
        controller.template = tagtemplate
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
