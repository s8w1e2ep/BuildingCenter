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
    var templateAry = [String?]()
    
    var templateIndex = 0
    var databasehelper = Databasehelper()
    var hipsterItem: HipsterItem!
    
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
        
        let imgdownload = ImageDownload()
        let hi = databasehelper.querytemplateTable()
        for i in hi{
            let bgPath = i.template
            let bgIndex = bgPath?.index((bgPath?.startIndex)!, offsetBy: 3)
            let element = DatabaseUtilizer.filePathURLPrefix + (bgPath?.substring(from: bgIndex!))!
            templateAry.append(element)
        }
        
        scrollView.contentSize = CGSize(
            width: CGFloat(self.view.bounds.width) * 0.85 * CGFloat(self.templateAry.count),
            height: scrollView.bounds.size.height
        )
        let size = scrollView.bounds.size
        var seq = 0
        for template in templateAry {
            let imageView = UIImageView()
            imgdownload.showpic(image: imageView, url: template!)
            if (seq == 0){
                imageView.frame = CGRect(x: size.width * 0.05, y: 0, width: size.width * 0.8, height: size.height * 0.95)
                seq = 1
            }
            else{
                imageView.frame = CGRect(x: CGFloat(seq) * size.width * 0.85 + size.width * 0.05, y: 0, width: size.width * 0.8, height: size.height * 0.95)
                seq = seq + 1
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
        var tarIndex = round(tarX / (scrollView.bounds.width * 0.85))
        if tarIndex < 0 {
            tarIndex = 0
        }
        if tarIndex >= maxIndex {
            tarIndex = maxIndex-1
        }
        
        var x = tarIndex * scrollView.bounds.width * 0.85 + 0.05
        
        if x == 0.05{
            x = 0
        }
        
        targetContentOffset.pointee.x = x
        templateIndex = Int(tarIndex)
    }

    @IBAction func nextButtononClick(_ sender: Any) {
        let imgdownload = ImageDownload()
        let imageView = UIImageView()
        imgdownload.showpic(image: imageView, url: templateAry[templateIndex]!)
        template = imageView.image!
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
