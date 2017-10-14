//
//  HipsterViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class HipsterViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var photoBtn: UIButton!
    
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText(selectLanguage: String){
        photoBtn.setTitle("\n\n"+"diary_photo".localized(language: selectLanguage), for: .normal)
        cameraBtn.setTitle("\n\n"+"diary_camera".localized(language: selectLanguage), for: .normal)
        
        if(BeginViewController.isEnglish){
            titleImage.image = #imageLiteral(resourceName: "title_english")
        }
        else{
            titleImage.image = #imageLiteral(resourceName: "title_chinese")
        }
    }
    
    /// 開啟相機或相簿
    ///
    /// - Parameter kind: 1=相機,2=相簿
    func callGetPhoneWithKind(_ kind: Int) {
        let picker: UIImagePickerController = UIImagePickerController()
        switch kind {
        case 1:
            // 開啟相機
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.allowsEditing = false // 可對照片作編輯
                picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                self.present(picker, animated: true, completion: nil)
            } else {
                print("沒有相機鏡頭...") // 用alertView.show
            }
        default:
            // 開啟相簿
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                picker.allowsEditing = false // 可對照片作編輯
                picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    // 相機
    @IBAction func onCameraBtnAction(_ sender: UIButton) {
        self.callGetPhoneWithKind(1)
    }
    
    // 相簿
    @IBAction func onPhotoBtnAction(_ sender: UIButton) {
        self.callGetPhoneWithKind(2)
    }

    /// 取得選取後的照片
    ///
    /// - Parameters:
    ///   - picker: pivker
    ///   - info: info
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil) // 關掉
        image = info[UIImagePickerControllerOriginalImage] as?UIImage
        self.performSegue(withIdentifier: "hipsterToSelect", sender: self) // 從Dictionary取出原始圖檔傳入下一頁
    }
    
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagimage = image
        let controller = segue.destination as! SelectViewController
        controller.image = tagimage
    }
    
}
