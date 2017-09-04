//
//  StringExtension.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 31/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

extension String {
    
    func localized(language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}

