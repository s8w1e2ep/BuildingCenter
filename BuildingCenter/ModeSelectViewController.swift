//
//  ModeSelectViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class ModeSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var thumbButton: UIBarButtonItem!
    
    @IBOutlet weak var modeSelectTitle: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    let databaseHelper = Databasehelper()
    
    var modeIntroViewController: ModeIntroViewController!
    
    var zoneItem: ZoneItem!
    var selectedCell: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        databaseHelper.querymodeTable()
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        if (databaseHelper.queryhintTable().mode_select == "0") {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ModeHint"){
                present(vc, animated: true)
            }
            databaseHelper.read_mode_select()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mode_select_to_intro" {
            modeIntroViewController = segue.destination as! ModeIntroViewController
            modeIntroViewController.zoneItem = zoneItem
            modeIntroViewController.selectedCell = selectedCell
        }
    }
    
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func onThumbClick(_ sender: UIBarButtonItem) {
        
        thumbButton.image = UIImage(named: "thumbup_orange.png")
        thumbButton.tintColor = UIColor.orange
        
        //upload count
        let zone = NSMutableDictionary()
        zone["zone_id"] = self.zoneItem.zone_id
        zone["like_count"] = 1
        
        if let JsonData = try? JSONSerialization.data(withJSONObject: zone, options: [])
        {
            print(JsonData)
            let JsontoUtf8 = String(data:JsonData,encoding:.utf8)
            var stringUrl = DatabaseUtilizer.zoneaddURL + "?zone_counts="
            stringUrl += JsontoUtf8!
            print(stringUrl)
            
            /*if let encodedURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                let url = NSURL(string: encodedURL)
                do{
                    let html = try String(contentsOf: url! as URL)
                    print(html)
                }catch{
                    print(error)
                }*/
                
            }
        
    }
    
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        modeSelectTitle.text = "mode_select_title".localized(language: selectLanguage)
        number.text = String(zoneItem.modes!.count)
        if BeginViewController.isEnglish {
            navBarTitle.title = zoneItem.name_en
        }else {
            navBarTitle.title = zoneItem.name
        }

    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return zoneItem.modes!.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ModeCell", for: indexPath as IndexPath) as! ModeCollectionViewCell

            // 設置 cell 內容 (即自定義元件裡 增加的圖片與文字元件)
            
            // set image
            let path = zoneItem.modes![indexPath.item].splash_bg_vertical
            let index = path?.index((path?.startIndex)!, offsetBy: 3)
            let imageName = DatabaseUtilizer.filePathURLPrefix + (path?.substring(from: index!))!
            //cell.backImage.downloadedFrom(link: imageName)
            let imgdownload = ImageDownload()
            //imgdownload.sessionSimpleDownload(urlpath: imageName)
            imgdownload.showpic(image: cell.backImage, url: imageName)
            //set text
            if BeginViewController.isEnglish {
                cell.textView.text = zoneItem.modes![indexPath.item].name_en
            }else {
                cell.textView.text = zoneItem.modes![indexPath.item].name
            }
            let contentSize = cell.textView.sizeThatFits(cell.textView.bounds.size)
            var frame = cell.textView.frame
            frame.size.height = contentSize.height
            cell.textView.frame = frame
            
            let aspectRatioTextViewConstraint = NSLayoutConstraint(item: cell.textView, attribute: .height, relatedBy: .equal, toItem: cell.textView, attribute: .width, multiplier: cell.textView.bounds.height/cell.textView.bounds.width, constant: 1)
            cell.textView.addConstraint(aspectRatioTextViewConstraint)
            
            if zoneItem.modes![indexPath.item].mode_did_read == "1" {
                cell.readImage.isHidden = false
                cell.read.isHidden = false
            }
            return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        selectedCell = indexPath.item
        
        
        if  zoneItem.modes![indexPath.item].mode_did_read == "0"{
            databaseHelper.update_mode_isread(modeID: zoneItem.modes![indexPath.item].mode_id!)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! ModeCollectionViewCell
        cell.readImage.isHidden = false
        cell.read.isHidden = false
        // ModeSelectView to ModeIntroView
        performSegue(withIdentifier: "mode_select_to_intro", sender: self)
    }
}
