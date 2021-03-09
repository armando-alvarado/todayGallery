//
//  GalleryPresenter.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 07/03/21.
//

import Foundation

protocol GalleryPresenterView: class {
    var slides: [Slide] {get set}
    var galleryTitle: String {get set}
    func updateGallery()
    func presentAlert(with error: String)
}


class GalleryPresenter {
    
    weak var view: GalleryPresenterView?
    
    lazy var httpClient: HTTPClient = {
        let session: URLSession = URLSession(configuration: .default)
        let baseURL = PlistParser.getStringValue(forKey: "BaseURL")
        return HTTPClient(baseURL: baseURL, urlSession: session)
    }()
    
    
    init(with view: GalleryPresenterView) {
        self.view = view
    }
    
    func getGallery() {
        httpClient.request(request: GetGallery()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gallery):
                if let slides = gallery.album?.slides {
                    self.view?.slides = slides
                    self.view?.galleryTitle = gallery.title
                    self.view?.updateGallery()
                }
            case .failure(let error):
                print("pasó un error: \(error.localizedDescription)")
                self.view?.presentAlert(with: error.localizedDescription)
            }
        }
    }
}
