//
//  ModeCollectionViewCell.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 07/09/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ModeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var read: UILabel!
    @IBOutlet weak var readImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var isRead = false
}
