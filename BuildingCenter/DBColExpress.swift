//
//  DBColExpress.swift
//  BuildingCenter
//
//  Created by uscc on 2017/9/5.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation
import SQLite

class DBColExpress{
    //zone
    static let zone_id = Expression<String?>(DatabaseUtilizer.ZONE_ID)
    static let name = Expression<String?>(DatabaseUtilizer.NAME)
    static let name_en = Expression<String?>(DatabaseUtilizer.NAME_EN)
    static let introduction = Expression<String?>(DatabaseUtilizer.INTRODUCTION)
    static let introduction_en = Expression<String?>(DatabaseUtilizer.INTRODUCTION_EN)
    static let guide_voice = Expression<String?>(DatabaseUtilizer.GUIDE_VOICE)
    static let guide_voice_en = Expression<String?>(DatabaseUtilizer.GUIDE_VOICE_EN)
    static let hint = Expression<String?>(DatabaseUtilizer.DEVICE_HINT)
    static let photo = Expression<String?>(DatabaseUtilizer.DEVICE_PHOTO)
    static let photo_vertical = Expression<String?>(DatabaseUtilizer.DEVICE_PHOTO_VER)
    static let field_id = Expression<String?>(DatabaseUtilizer.FIELD_ID)
    
    //mode
    static let mode_id = Expression<String?>(DatabaseUtilizer.MODE_ID)
    static let video = Expression<String?>(DatabaseUtilizer.VIDEO)
    static let splash_bg_vertical = Expression<String?>(DatabaseUtilizer.MODE_SPLASH_BG)
    static let splash_fg_vertical = Expression<String?>(DatabaseUtilizer.MODE_SPLASH_FG)
    static let splash_blur_vertical = Expression<String?>(DatabaseUtilizer.MODE_SPLASH_BLUR)
    
    //device
    static let device_id = Expression<String?>(DatabaseUtilizer.DEVICE_ID)
    static let company_id = Expression<String?>(DatabaseUtilizer.COMPANY_ID)

}
