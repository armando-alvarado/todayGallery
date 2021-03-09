//
//  Slide.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation

struct Slide: Codable {
    var caption: String
    var publishUrl: String
    var smallBaseName: String
    var credit: String
    var date: String

    enum CodingKeys: String, CodingKey {
        case metaData
        case items
        case caption
        case publishurl
        case smallbasename
        case credit
        case datephototaken
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let metaData = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .metaData)
        let items = try metaData.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        caption = try items.decode(String.self, forKey: .caption)
        publishUrl = try items.decode(String.self, forKey: .publishurl)
        smallBaseName = try items.decode(String.self, forKey: .smallbasename)
        credit = try items.decode(String.self, forKey: .credit)
        date = try items.decode(String.self, forKey: .datephototaken)
    }

    func encode(to encoder: Encoder) throws {}
}
