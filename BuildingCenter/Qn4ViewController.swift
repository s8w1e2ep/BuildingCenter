//
//  Qn4ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn4ViewController: UIViewController ,ZHDropDownMenuDelegate{

    @IBOutlet var menu1: ZHDropDownMenu!
    @IBOutlet var menu2: ZHDropDownMenu!
    @IBOutlet var menu3: ZHDropDownMenu!
    @IBOutlet var navbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.barTintColor = UIColor.white

        menu1.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu2.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu3.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]

        menu1.menuHeight = 200;
        menu2.menuHeight = 200;
        menu3.menuHeight = 200;
        
        menu1.delegate = self
        menu2.delegate = self
        menu3.delegate = self

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn4toQn5", sender: self);
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
