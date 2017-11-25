//
//  CurrencyInfo.swift
//  Crypto Convert
//
//  Created by Crownstack on 25/11/17.
//  Copyright © 2017 Crownstack. All rights reserved.
//

import Foundation
import UIKit

class CurrencyInfo {
    var imageView = UIImageView()
    var code = ""
    var imageUrl = ""
    var image = Data()

    class func parseCurrency(_ currency: NSDictionary,baseImageUrl: String) -> CurrencyInfo {
        let currencyInfoObject = CurrencyInfo()
        currencyInfoObject.code = currency.value(forKey: "Symbol") as? String ?? ""
        currencyInfoObject.imageUrl = currency.value(forKey: "ImageUrl") as? String ?? ""
 
        return currencyInfoObject
    }
}
