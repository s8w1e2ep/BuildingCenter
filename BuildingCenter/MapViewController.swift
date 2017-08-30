//
//  MapViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import JavaScriptCore
class MapViewController: UIViewController, UIWebViewDelegate {
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var SVGView: UIWebView!
    var jsContext: JSContext!
    var nowRegion: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        SVGView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        
        do {
            let indexPath = Bundle.main.path(forResource: "index", ofType: "html")!
            let contents = try String(contentsOfFile: indexPath, encoding: .utf8)
            let indexURL = URL(fileURLWithPath: indexPath)
            SVGView.loadHTMLString(contents as String, baseURL: indexURL)
            
            
            
        }
        catch {
            print ("File HTML error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isMapLaunchBefore = defaults.bool(forKey: "isMapLaunchBefore")
        
        if (!isMapLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "InfoHint"){
                //show(vc, sender: self)
                present(vc, animated: true)
                
            }
            defaults.set(true, forKey: "isMapLaunchBefore")
        }
    }
    @IBAction func goQuestionnaire(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToQuestionnaire", sender: self);
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        //check view have load finish jsContext will be set
        jsContext = self.SVGView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        setSVGBG(BGName: "bg")
        setSVGMap(SVGName: "Map_1F")
        nowRegion = 0
        
        //        web1.scrollView.minimumZoomScale = 1.0
        //        web1.scrollView.maximumZoomScale = 5.0
        //        web1.scrollView.zoomScale = 3.0
    }
    
    func setSVGBG(BGName: String){
        let BGPath = Bundle.main.path(forResource: "" + BGName, ofType: "jpg")
        jsContext.objectForKeyedSubscript("setBG")!.call(withArguments: ["url(" + BGPath! + ")"])
    }
    
    func setSVGMap(SVGName: String){
        let SVGPath = Bundle.main.path(forResource: "" + SVGName, ofType: "svg")
        if(nowRegion == 11){
            jsContext.objectForKeyedSubscript("setSVGLoad")!.call(withArguments: ["" + SVGPath!,11,12,"",""])
        }else{
            jsContext.objectForKeyedSubscript("setSVGLoad")!.call(withArguments: ["" + SVGPath!,0,1,"",""])
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url!.absoluteString.hasPrefix("app://"){
            let request = request.url?.absoluteString as! String
            let argu = request.components(separatedBy: "://")
            let argu2 = argu[1].components(separatedBy: "?")
            let width = SVGView.frame.width
            let height = SVGView.frame.height
            
            switch argu2[0]{
            case "ma":
                break
            case "mn":
                nowRegion += 1
                if(nowRegion==11){
                    SVGView.stringByEvaluatingJavaScript(from: "onRegionChanged(\(nowRegion),'\(nowRegion+1)','p\(nowRegion-1)-\(nowRegion)','p\(nowRegion)-2f')")
                }else{
                    SVGView.stringByEvaluatingJavaScript(from: "onRegionChanged(\(nowRegion),\(nowRegion+1),'p\(nowRegion-1)-\(nowRegion)','p\(nowRegion)-\(nowRegion+1)')")
                }
                //set bar changed
                break
            case "mv":
                //set bar changed
                break
            case "set":
                if (argu2[1] == "focus"){
                    SVGView.stringByEvaluatingJavaScript(from: "setScreenFocus(\(nowRegion),2,2,1)")
                }else if(argu2[1] == "1f_2f"){
                    nowRegion = 11
                    setSVGMap(SVGName: "Map_2F")
                }else if(argu2[1] == "2f_1f"){
                    nowRegion = 0
                    setSVGMap(SVGName: "Map_1F")
                }
                break
            default:
                break
            }
        }
        return true
        
    }


}
