//
//  Gallery.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 07/03/21.
//

import Foundation

struct Gallery: Codable {
    var title: String
    var album: Album?

    enum CodingKeys: String, CodingKey {
        case title
        case albums
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let albums = try container.decode([Album].self, forKey: .albums)
        self.title = title
        self.album = albums[0]
    }

    func encode(to encoder: Encoder) throws {}
}
