//
//  SelectViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/7/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage!
    var template: UIImage!
    var templateAry = [
        ["pic":"template_1.png"],
        ["pic":"template_2.png"]
    ]
    
    var templateIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setLayout()
    }
    
    func setText(selectLanguage: String){
        navItem.title = "choose_template".localized(language:selectLanguage)
        nextBtn.setTitle("nextstep".localized(language:selectLanguage),for: .normal)
    }
    
    func setLayout(){
        scrollView.contentSize = CGSize(
            width: CGFloat(self.view.bounds.width) * 0.85 * CGFloat(self.templateAry.count),
            height: scrollView.bounds.size.height
        )
        let size = scrollView.bounds.size
        
        for (seq,template) in templateAry.enumerated() {
            let imageView = UIImageView(image: UIImage(named: template["pic"]!))
            if (seq == 0){
                imageView.frame = CGRect(x: size.width * 0.05, y: 0, width: size.width * 0.8, height: size.height * 0.95)
            }
            else{
                imageView.frame = CGRect(x: CGFloat(seq) * size.width * 0.85 + size.width * 0.05, y: 0, width: size.width * 0.8, height: size.height * 0.95)
            }
            scrollView.addSubview(imageView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let maxIndex = CGFloat(templateAry.count)
        let tarX = scrollView.contentOffset.x + velocity.x * 80
        var tarIndex = round(tarX / (scrollView.bounds.width * (1 - maxIndex * 0.1)))
        if tarIndex < 0 {
            tarIndex = 0
        }
        if tarIndex > maxIndex {
            tarIndex = maxIndex
        }
        targetContentOffset.pointee.x = tarIndex * scrollView.bounds.width * (1 - maxIndex * 0.1)
        templateIndex = Int(tarIndex)
    }

    @IBAction func nextButtononClick(_ sender: Any) {
        template = UIImage(named: templateAry[templateIndex]["pic"]!)
        self.performSegue(withIdentifier: "selectToWriting", sender: self)
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagimage = image
        let tagtemplate = template
        let tagindex = templateIndex
        let controller = segue.destination as! WritingViewController
        controller.image = tagimage
        controller.template = tagtemplate
        controller.index = tagindex
    }
    

}
