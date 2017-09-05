//
//  StringExtension.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 31/08/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func localized(language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
extension String {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(
                data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
        } catch {
            print(error)
        }
        return nil
    }
}


