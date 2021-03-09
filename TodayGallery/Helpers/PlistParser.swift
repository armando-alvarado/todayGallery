//
//  PlistParser.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation

struct PlistParser {
    static func getStringValue(forKey key:String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else {
            fatalError("Coutn'd retrieve \(key) from plist file")
        }
        return value
    }
}
