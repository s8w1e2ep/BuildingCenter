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
    @IBOutlet weak var stackView: UIStackView!
    var index = 0
    var original_x: CGFloat!
    var new_x: CGFloat!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        original_x = 0
        index = 0
        //self.imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        
        print("fist x = ", scrollView.contentOffset.x)
        print("original_x = ", original_x)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("x = ", scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var left: CGFloat!
        left = original_x - 225
        var right: CGFloat!
        right = original_x + 225
        if (scrollView.contentOffset.x < left){
            new_x = original_x - 300
            index = index - 1
        }
        else if(scrollView.contentOffset.x > right){
            new_x = original_x + 300
            index = index + 1
        }
        else{
            new_x = original_x
        }
        if(new_x < 0){
            new_x = 0
            index = 0
        }
        if(new_x >= stackView.frame.width - 330){
            new_x = new_x - 54
            index = index - 1
        }
        scrollView.contentOffset.x = new_x
        original_x = scrollView.contentOffset.x
        print("end x = ", scrollView.contentOffset.x)
        print("new_x = ", new_x)
        print("scrollViewDidEndDragging")
    }

    @IBAction func nextButtononClick(_ sender: Any) {
        self.performSegue(withIdentifier: "selectToWriting", sender: #imageLiteral(resourceName: "template_1"))
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tag = sender as? UIImage
        let controller = segue.destination as! WritingViewController
        controller.image = tag
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
