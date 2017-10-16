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
    static let mode_did_read = Expression<String?>(DatabaseUtilizer.MODE_DID_READ)
    //device
    static let device_id = Expression<String?>(DatabaseUtilizer.DEVICE_ID)
    static let company_id = Expression<String?>(DatabaseUtilizer.COMPANY_ID)
    
    //company
    static let tel = Expression<String?>(DatabaseUtilizer.COMPANY_TEL)
    static let addr = Expression<String?>(DatabaseUtilizer.COMPANY_ADDR)
    static let fax = Expression<String?>(DatabaseUtilizer.COMPANY_FAX)
    static let web = Expression<String?>(DatabaseUtilizer.COMPANY_WEB)
    static let qrcode = Expression<String?>(DatabaseUtilizer.QRCODE)
    
    //beacon
    static let beacon_id = Expression<String?>(DatabaseUtilizer.BEACON_ID)
    static let beacon_zone = Expression<String?>(DatabaseUtilizer.BEACON_ZONE)
    static let beacon_field_id = Expression<String?>(DatabaseUtilizer.BEACON_FIELD_ID)
    static let beacon_field_name = Expression<String?>(DatabaseUtilizer.BEACON_FIELD_NAME)
    static let beacon_mac_addr = Expression<String?>(DatabaseUtilizer.MAC_ADDR)
    
    //hint
    static let hint_guider = Expression<String?>(DatabaseUtilizer.HINT_GUIDER)
    static let hint_mode_select = Expression<String?>(DatabaseUtilizer.HINT_MODE_SELECT)
    static let hint_mode_content = Expression<String?>(DatabaseUtilizer.HINT_MODE_CONTENT)
    static let hint_map_info = Expression<String?>(DatabaseUtilizer.HINT_MAP_INFO)
    static let hint_id = Expression<String?>(DatabaseUtilizer.HINT_ID)
    
    static let is_like = Expression<String?>(DatabaseUtilizer.IS_LIKE)
    
    //hipster
    static let hipster_text_id = Expression<String?>(DatabaseUtilizer.HIPSTER_TEXT_ID)
    static let content = Expression<String?>(DatabaseUtilizer.CONTENT)
    static let content_en = Expression<String?>(DatabaseUtilizer.CONTENT_EN)
    
}
