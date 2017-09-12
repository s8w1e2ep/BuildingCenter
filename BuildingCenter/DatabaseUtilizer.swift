//
//  DatabaseUtilizer.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 31/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class DatabaseUtilizer {
    // base IP address
    //estatic let IP :String = "60.251.33.54:98";
    static let IP :String = "192.168.65.28";
    
    static let serverURL :String = "http://" + IP + "/interface/jsondecode.php";
    static let testServer  :String = "http://" + IP + "/interface/test.php"; // test server
    static let downloadURL  :String = "http://" + IP + "/interface/getfile.php";
    static let hipsterContentURL :String = "http://" + IP + "/interface/hipster.php"; // hipster content
    static let surveyOneURL :String = "http://" + IP + "/interface/survey.php"; // first survey
    static let feedbackURL :String = "http://" + IP + "/interface/survey2.php";
    static let deviceaddURL :String = "http://" + IP + "/interface/deviceadd.php"; // counter
    static let modeaddURL :String = "http://" + IP + "/interface/modeadd.php"; // counter
    static let zoneaddURL :String = "http://" + IP + "/interface/zoneadd.php"; // counter
    static let filePathURLPrefix :String = "http://" + IP + "/web/";
    // 8/30/2017
    static let counttypeURL :String = "http://" + IP + "/interface/count_type.php";
    
    /*
     declare useful strings for downloading & uploading data
     */
    
    // general usage
    static let NAME :String = "name";
    static let NAME_EN :String = "name_en";
    static let INTRODUCTION :String = "introduction";
    static let INTRODUCTION_EN :String = "introduction_en";
    static let GUIDE_VOICE :String = "guide_voice";
    // guide_voice_size
    static let TEMPLATE_SIZE :String = "template_size";
    static let GUIDE_VOICE_EN :String = "guide_voice_en";
    static let VIDEO :String = "video";
    static let PHOTO_SIZE :String = "photo_size";
    static let PHOTO_VERTICAL_SIZE :String = "photo_vertical_size";
    static let READ_COUNT :String = "read_count";
    static let LIKE_COUNT :String = "like_count";
    static let TIME_TOTAL :String = "time_total";
    static let CREATE_DATE :String = "create_date";
    static let X :String = "x";
    static let Y :String = "y";
    static let EMAIL :String = "email";
    
    // project table
    static let PROJECT_ID :String = "project_id";
    
    // device table
    static let DEVICE_TABLE :String = "device";
    static let DEVICE_ID :String = "device_id";
    static let DEVICE_PHOTO :String = "photo";
    static let DEVICE_PHOTO_VER :String = "photo_vertical";
    static let DEVICE_HINT :String = "hint";
    static let DEVICE_MODE_ID :String = "mode_id";
    static let DEVICE_COMPANY_ID :String = "company_id";
    
    // mode table
    static let MODE_TABLE :String = "mode";
    static let MODE_ID :String = "mode_id";
    static let MODE_NAME :String = "name";
    static let MODE_SPLASH_BG :String = "splash_bg_vertical";
    static let SPLASH_BG_SIZE :String = "splash_bg_vertical_size";
    static let MODE_SPLASH_FG :String = "splash_fg_vertical";
    static let SPLASH_FG_SIZE :String = "splash_fg_vertical_size";
    static let MODE_SPLASH_BLUR :String = "splash_blur_vertical";
    static let SPLASH_BLUR_SIZE :String = "splash_blur_vertical_size";
    static let MODE_DID_READ :String = "did_read";
    
    // zone table
    static let ZONE_TABLE :String = "zone";
    static let ZONE_ID :String = "zone_id";
    static let FIELD_ID :String = "field_id";
    
    // path table
    static let PATH_TABLE :String = "path"; // path
    static let CHOOSE_PATH_ID :String = "choose_path_id"; // int
    static let PATH_ORDER :String = "path_order"; // int
    static let PATH_SVG_ID :String = "svg_id"; // int
    static let START :String = "start"; // start
    static let PATH_SN :String = "Sn"; // Sn
    static let END :String = "end";
    static let PATH_EN :String = "En"; // En
    
    // beacon table
    static let BEACON_TABLE :String = "beacon";
    static let BEACON_ID :String = "beacon_id";
    static let BEACON_POWER :String = "power";
    static let BEACON_STATUS :String = "status";
    static let BEACON_ZONE :String = "zone";
    static let BEACON_FIELD_NAME :String = "field_name";
    static let BEACON_FIELD_ID :String = "field_id";
    
    // company
    static let COMPANY_TABLE :String = "company";
    static let COMPANY_ID :String = "company_id";
    static let COMPANY_TEL :String = "tel";
    static let COMPANY_FAX :String = "fax";
    static let COMPANY_ADDR :String = "addr";
    static let COMPANY_WEB :String = "web";
    static let QRCODE :String = "qrcode";
    
    // field map table
    static let FIELD_MAP_TABLE :String = "field_map";
    static let FIELD_MAP_ID :String = "field_map_id";
    static let MAP_SVG :String = "map_svg";
    static let MAP_SVG_EN :String = "map_svg_en";
    static let MAP_BG :String = "map_bg";
    static let MAP_SVG_SIZE :String = "map_svg_size";
    static let MAP_SVG_EN_SIZE :String = "map_svg_en_size";
    static let MAP_BG_SIZE :String = "map_bg_size";
    
    // hipster template table
    static let HIPSTER_TEMPLATE_TABLE :String = "hipster_template";
    static let HIPSTER_TEMPLATE_ID :String = "hipster_template_id";
    static let TEMPLATE :String = "template";
    
    // hipster text table
    static let HIPSTER_TEXT_TABLE :String = "hipster_text";
    static let HIPSTER_TEXT_ID :String = "hipster_text_id";
    static let CONTENT :String = "content";
    static let CONTENT_EN :String = "content_en";
    static let MAC_ADDR :String = "mac_addr";
    
    // TODO: not sure last update time & isDelete is required or not
    static let LASTUPDATE_DATE :String = "lastupdate_date";
    
    // device
    static let DB_CREATE_TABLE_DEVICE :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.DEVICE_TABLE + " ("
        + DatabaseUtilizer.DEVICE_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.INTRODUCTION + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.INTRODUCTION_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.GUIDE_VOICE + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.GUIDE_VOICE_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.DEVICE_PHOTO + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.PHOTO_SIZE + " INT DEFAULT 0, "
        + DatabaseUtilizer.DEVICE_PHOTO_VER + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.PHOTO_VERTICAL_SIZE + " INT DEFAULT 0, "
        + DatabaseUtilizer.DEVICE_HINT + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.DEVICE_MODE_ID + " INT NOT NULL, "
        + DatabaseUtilizer.DEVICE_COMPANY_ID + " INT DEFAULT NULL, "
        + DatabaseUtilizer.READ_COUNT + " INT DEFAULT 0, "
        + DatabaseUtilizer.LIKE_COUNT + " INT DEFAULT 0"
        + ")";
    // beacon
    static let DB_CREATE_TABLE_BEACON :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.BEACON_TABLE + " ("
        + DatabaseUtilizer.BEACON_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.MAC_ADDR + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.BEACON_POWER + " INT NOT NULL, "
        + DatabaseUtilizer.BEACON_STATUS + " INT NOT NULL, "
        + DatabaseUtilizer.BEACON_ZONE + " INT NOT NULL, "
        + DatabaseUtilizer.X + " INT NOT NULL, "
        + DatabaseUtilizer.Y + " INT NOT NULL, "
        + DatabaseUtilizer.BEACON_FIELD_ID + " INT, "
        + DatabaseUtilizer.BEACON_FIELD_NAME + " TEXT"
        + ")";
    // company
    static let DB_CREATE_TABLE_COMPANY :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.COMPANY_TABLE + " ("
        + DatabaseUtilizer.COMPANY_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.COMPANY_TEL + " TEXT NOT NULL, "
        + DatabaseUtilizer.COMPANY_FAX + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.COMPANY_ADDR + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.COMPANY_WEB + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.QRCODE + " TEXT DEFAULT NULL"
        + ")";
    // field map
    static let DB_CREATE_TABLE_FIELD_MAP :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.FIELD_MAP_TABLE + " ("
        + DatabaseUtilizer.FIELD_MAP_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.PROJECT_ID + " INT NOT NULL, "
        + DatabaseUtilizer.INTRODUCTION + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.DEVICE_PHOTO + " TEXT NOT NULL, "
        + DatabaseUtilizer.PHOTO_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.DEVICE_PHOTO_VER + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.PHOTO_VERTICAL_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.MAP_SVG + " TEXT NOT NULL, "
        + DatabaseUtilizer.MAP_SVG_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.MAP_SVG_EN + " TEXT NOT NULL, "
        + DatabaseUtilizer.MAP_SVG_EN_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.MAP_BG + " TEXT NOT NULL, "
        + DatabaseUtilizer.MAP_BG_SIZE + " INT NOT NULL DEFAULT 0"
        + ")";
    // hipster template
    static let DB_CREATE_TABLE_HIPSTER_TEMPLATE :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.HIPSTER_TEMPLATE_TABLE + " ("
        + DatabaseUtilizer.HIPSTER_TEMPLATE_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.TEMPLATE + " TEXT NOT NULL, "
        + DatabaseUtilizer.TEMPLATE_SIZE + " INT NOT NULL DEFAULT 0"
        + ")";
    // hipster text
    static let DB_CREATE_TABLE_HIPSTER_TEXT :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.HIPSTER_TEXT_TABLE + " ("
        + DatabaseUtilizer.HIPSTER_TEXT_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.CONTENT + " TEXT NOT NULL, "
        + DatabaseUtilizer.CONTENT_EN + " TEXT NOT NULL"
        + ")";
    // mode
    static let DB_CREATE_TABLE_MODE :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.MODE_TABLE + " ("
        + DatabaseUtilizer.MODE_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.MODE_NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.INTRODUCTION + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.INTRODUCTION_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.GUIDE_VOICE + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.GUIDE_VOICE_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.VIDEO + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.MODE_SPLASH_BG + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.SPLASH_BG_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.MODE_SPLASH_FG + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.SPLASH_FG_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.MODE_SPLASH_BLUR + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.SPLASH_BLUR_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.LIKE_COUNT + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.READ_COUNT + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.TIME_TOTAL + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.ZONE_ID + " INT NOT NULL, "
        + DatabaseUtilizer.MODE_DID_READ + " INT DEFAULT 0"
        + ")";
    // path --> path_id is the only primary key, different from database
    static let DB_CREATE_TABLE_PATH :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.PATH_TABLE + " ("
        + DatabaseUtilizer.CHOOSE_PATH_ID + " INT NOT NULL, "
        + DatabaseUtilizer.PATH_ORDER + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.PATH_SVG_ID + " TEXT, "
        + DatabaseUtilizer.START + " INT, "
        + DatabaseUtilizer.PATH_SN + " TEXT, "
        + DatabaseUtilizer.END + " INT, "
        + DatabaseUtilizer.PATH_EN + " TEXT"
        + ")";
    // zone
    static let DB_CREATE_TABLE_ZONE :String = "CREATE TABLE IF NOT EXISTS " + DatabaseUtilizer.ZONE_TABLE + " ("
        + DatabaseUtilizer.ZONE_ID + " INT NOT NULL UNIQUE, "
        + DatabaseUtilizer.NAME + " TEXT NOT NULL, "
        + DatabaseUtilizer.NAME_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.INTRODUCTION + " TEXT, "
        + DatabaseUtilizer.INTRODUCTION_EN + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.GUIDE_VOICE + " TEXT, "
        + DatabaseUtilizer.GUIDE_VOICE_EN + " TEXT, "
        + DatabaseUtilizer.DEVICE_HINT + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.DEVICE_PHOTO + " TEXT NOT NULL, "
        + DatabaseUtilizer.PHOTO_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.DEVICE_PHOTO_VER + " TEXT DEFAULT NULL, "
        + DatabaseUtilizer.PHOTO_VERTICAL_SIZE + " INT NOT NULL DEFAULT 0, "
        + DatabaseUtilizer.FIELD_ID + " INT NOT NULL, "
        + DatabaseUtilizer.LIKE_COUNT + " INT DEFAULT 0"
        + ")";
    
    func getIP() -> String{
        return DatabaseUtilizer.IP;
    }
}
