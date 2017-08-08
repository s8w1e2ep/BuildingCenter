//
//  MapViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var SVGView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        do {
            guard let filePath = Bundle.main.path(forResource: "map", ofType: "svg")
                else {
                    print ("File reading error")
                    return
            }
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            SVGView.loadHTMLString(contents as String, baseURL: baseUrl)
            //web1.scalesPageToFit = YES;
            //let testJSFunction = web1.stringByEvaluatingJavaScript(from: "jstest()");
            //let loadJavascript = "setSVGLoad('" + SVGMap + "','-1','1','','' )"
            
            
        }
        catch {
            print ("File HTML error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let contentSize:CGSize = SVGView.scrollView.contentSize
        let viewSize:CGSize = self.view.bounds.size
        let rw = viewSize.width / contentSize.width
        SVGView.scrollView.minimumZoomScale = rw
        SVGView.scrollView.maximumZoomScale = rw
        SVGView.scrollView.zoomScale = rw
    }

}
