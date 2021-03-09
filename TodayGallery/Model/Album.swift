//
//  Album.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation

struct Album: Codable {
    var title: String
    var slides: [Slide]?

    enum AlbumCodingKeys: String, CodingKey {
        case title
        case slides
    }
}
