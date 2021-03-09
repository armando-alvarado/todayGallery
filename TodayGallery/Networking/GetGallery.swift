//
//  GetGallery.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation

struct GetGallery: HTTPRequest {
    typealias Response = Gallery

    let urlPath: String
    let method: HTTPMethod = .get

    init() {
        urlPath = "/gallery?galleryId=5197105&api_key=rtxdju9wfw78treew9uuhhsj"
    }
}
