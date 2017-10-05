//
//  MapViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import JavaScriptCore
class MapViewController: UIViewController, UIWebViewDelegate, BeaconScanResultListener {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var SVGView: UIWebView!
    
    // To enter zone introduction
    @IBOutlet weak var notice: UIImageView!
    @IBOutlet var barTitle: DropMenuButton!
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var zoneName: UILabel!
    @IBOutlet weak var enterImage: UIImageView!
    
    let notificationExitMap = Notification.Name("exitMapNoti")
    
    var bleScannerWrapper: BleScannerWrapper!
    
    var zoneViewController: AreaViewController!
    
    var currentField = "1"
    
    var jsContext: JSContext!
    var nowRegion: Int = 0
    
    var selectedZone = 0
    
    let databaseHelper = Databasehelper()
    var zoneItems: [ZoneItem]!
    var zoneItem: ZoneItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBartitle()
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setSVG()
        getZoneItems()
        bleScannerWrapper = BleScannerWrapper.getInstance()
        bleScannerWrapper.beaconScanResultListener = self
    }
    override func viewWillAppear(_ animated: Bool) {
        bleScannerWrapper.startBleScan()
    }
    override func viewWillDisappear(_ animated: Bool) {
        bleScannerWrapper.stopBleScan()
        
        // Need to disselect map button in MainPageViewController
        NotificationCenter.default.post(name: notificationExitMap, object: nil, userInfo: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if launch before to show useful hint.
        /*let defaults = UserDefaults.standard
        let isMapLaunchBefore = defaults.bool(forKey: "isMapLaunchBefore")
        
        if (!isMapLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "InfoHint"){
                present(vc, animated: true)
            }
            defaults.set(true, forKey: "isMapLaunchBefore")
        }*/
        if (databaseHelper.queryhintTable().map_info == "0") {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "InfoHint"){
                present(vc, animated: true)
            }
            databaseHelper.read_map_info()
        }
    }
    
    
    func onBeaconScanResult(_ beaconMap: [AnyHashable : Any]!) {
        processBeaconScanResults(beaconMap: beaconMap as NSDictionary)
    }
    func processBeaconScanResults(beaconMap: NSDictionary){
        var mac = ""
        
        
        for i in beaconMap.allKeys{
            mac = String(describing: i)
        }
        if mac == "" {
            return
        }
        print("Beacon:")
        print(String(describing: mac) + ":" + String(describing: beaconMap[mac]))
        /*
        // 跟上一個 Beacon 一樣
        if mac == lastScanBeacon.mac {
            return
        }
        var currentBeacon = queryBeaconByMac(mac)
        if currentBeacon == NSNull{
            return
        }
        */
        
    }
    /*
    func getHighestRssiDevice(beaconMap: NSDictionary){
        for i in beaconMap.allKeys{
            
            print(String(describing: i) + ":" + String(describing: beaconMap[i]))
        }
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map_to_zone" {
            zoneViewController = segue.destination as! AreaViewController
            zoneViewController.zoneItem = zoneItem
        }
    }
    
    @IBAction func goQuestionnaire(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToQuestionnaire", sender: self);
    }
    
    @IBAction func onEnterClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "map_to_zone", sender: self);
    }
    
    @IBAction func onCancelClick(_ sender: UIButton) {
        setNoticeIsHidden(isHidden: true)
    }
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        // set notice init hidden
        setNoticeIsHidden(isHidden: true)
    }
    func setNoticeIsHidden(isHidden: Bool) {
        
        notice.isHidden = isHidden
        enter.isHidden = isHidden
        enterImage.isHidden = isHidden
        cancel.isHidden = isHidden
        zoneName.isHidden = isHidden
    }
    func setNoticeZoneName() {
        if BeginViewController.isEnglish {
            zoneName.text = zoneItem.name_en
        }
        else {
            zoneName.text = zoneItem.name
        }
    }
    func setBartitle(){
        
        if BeginViewController.isEnglish {
         barTitle.initMenu(["1F", "2F"], actions: [({ () -> (Void) in self.setSVGMap(SVGName: "Map_1F") }), ({ () -> (Void) in self.setSVGMap(SVGName: "Map_2F") })])
         }else {
            barTitle.initMenu(["1F 住宅展示中心", "2F 住宅展示中心"], actions: [({ () -> (Void) in self.setSVGMap(SVGName: "Map_1F") }), ({ () -> (Void) in self.setSVGMap(SVGName: "Map_2F") })])
         
         }
        
    }
    func setText(selectLanguage: String) {
        // according to language set text
        enter.setTitle("map_area_enter".localized(language: selectLanguage), for: .normal)
        barTitle.setTitle("map_title".localized(language: selectLanguage), for: .normal)
    
    }
    func getZoneItems() {
        zoneItems = databaseHelper.queryzoneTable()
    }
    func getZoneItem() {
        for zone in zoneItems {
            if zone.zone_id == String(selectedZone) {
                zoneItem = zone
                break
            }
        }
    }
    func setSVG() {
        SVGView.delegate = self
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
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        //check view have load finish jsContext will be set
        jsContext = self.SVGView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        setSVGBG(BGName: "bg")
        setSVGMap(SVGName: "Map_1F")
        nowRegion = 0
        
        //        web1.scrollView.minimumZoomScale = 1.0
        //        web1.scrollView.maximumZoomScale = 5.0
        //        web1.scrollView.zoomScale = 3.0
        SVGView.scrollView.setZoomScale(2.8, animated: true)
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
            //let width = SVGView.frame.width
            //let height = SVGView.frame.height
            
            switch argu2[0]{
            case "ma":
                //set bar changed
                selectedZone = Int(argu2[1])!
                getZoneItem()
                setNoticeZoneName()
                setNoticeIsHidden(isHidden: false)
                break
            case "mn":
                nowRegion += 1
                if(nowRegion==11){
                    SVGView.stringByEvaluatingJavaScript(from: "onRegionChanged(\(nowRegion),'\(nowRegion+1)','p\(nowRegion-1)-\(nowRegion)','p\(nowRegion)-2f')")
                }else{
                    SVGView.stringByEvaluatingJavaScript(from: "onRegionChanged(\(nowRegion),\(nowRegion+1),'p\(nowRegion-1)-\(nowRegion)','p\(nowRegion)-\(nowRegion+1)')")
                }
                //set bar changed
                selectedZone = nowRegion
                getZoneItem()
                setNoticeZoneName()
                setNoticeIsHidden(isHidden: false)
                break
            case "mv":
                //set bar changed
                selectedZone = Int(argu2[1])!
                getZoneItem()
                setNoticeZoneName()
                setNoticeIsHidden(isHidden: false)
                break
            case "set":
                if (argu2[1] == "focus"){
                    SVGView.stringByEvaluatingJavaScript(from: "setScreenFocus(\(nowRegion),2,2,1)")
                }else if(argu2[1] == "1f_2f"){
                    nowRegion = 11
                    currentField = "2"
                    setSVGMap(SVGName: "Map_2F")
                }else if(argu2[1] == "2f_1f"){
                    nowRegion = 0
                    currentField = "1"
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
