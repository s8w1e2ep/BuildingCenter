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
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    var templateItem = 0
    var image: UIImage!
    var template: UIImage!
    var templateAry = [
        ["pic":"template_1.png"],
        ["pic":"template_2.png"]
    ]
    var uiImageViewary : [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        print("contenView width = \(contenView.bounds.width)")
        print("slef width = \(self.contenView.bounds.width)")
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setLayout(){
        scrollView.delegate = self
        let size = scrollView.bounds.size
        for (seq,templateel) in templateAry.enumerated() {
            let uiImageView = UIImageView(image: UIImage(named: templateel["pic"]!))
            uiImageView.frame = CGRect(x: CGFloat(seq) * size.width * 0.85, y: 0, width: size.width * 0.8, height: size.height)
            //uiImageViewary.append(uiImageView)
            stackView.addSubview(uiImageView)//uiImageViewary[index])
        }
        stackView.bounds.size.width = CGFloat(templateAry.count) * (size.width * 0.9) - size.width * 0.1
        stackView.spacing = size.width * 0.1
        contenView.bounds.size.width = stackView.bounds.size.width + stackView.spacing
        scrollView.contentSize = CGSize(width: (-1) * contenView.bounds.width, height: contenView.bounds.height)
        scrollView.contentOffset.x = (-contenView.bounds.width)
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
    /*
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
    */
    
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
