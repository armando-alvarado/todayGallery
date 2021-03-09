//
//  GalleryItemCollectionViewCell.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 07/03/21.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadowView: UIView!

    var item: Slide? {
        didSet {
            titleLabel.text = item?.caption
            guard let baseURL = item?.publishUrl, let endpoint = item?.smallBaseName else { return }
            imageView.contentMode = .scaleAspectFill
            imageView.loadImage(urlString: "\(baseURL)\(endpoint)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowRadius = 1
        shadowView.layer.shouldRasterize = true
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
