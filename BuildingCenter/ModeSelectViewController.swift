//
//  ModeSelectViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var modeSelectTitle: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isModeLaunchBefore = defaults.bool(forKey: "isModeLaunchBefore")
        
        if (!isModeLaunchBefore) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ModeHint"){
                //show(vc, sender: self)
                present(vc, animated: true)
                
            }
            defaults.set(true, forKey: "isModeLaunchBefore")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func setLayout() {
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    func setText(selectLanguage: String) {
        // according to language set text
        modeSelectTitle.text = "mode_select_title".localized(language: selectLanguage)
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ModeCell", for: indexPath as IndexPath)

            // 設置 cell 內容 (即自定義元件裡 增加的圖片與文字元件)
            /*cell.imageView.image =
                UIImage(named: "a1m4_bg.png")
             */
            return cell
    }
}
