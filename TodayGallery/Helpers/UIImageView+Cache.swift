//
//  UIImageView+Cache.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 07/03/21.
//


import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImage(urlString: String) {

        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self,
                  let imageData: Data = try? Data(contentsOf: url as URL),
                  let imageToCache = UIImage(data: imageData as Data) else {
                return
            }
            DispatchQueue.main.async {
                self.image = imageToCache
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
        }

    }
}
