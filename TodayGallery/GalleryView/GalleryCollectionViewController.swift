//
//  GalleryCollectionViewController.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 07/03/21.
//

import UIKit

class GalleryCollectionViewController: UIViewController {

    lazy var presenter = GalleryPresenter(with: self)

    var galleryTitle: String = ""
    var slides: [Slide] = []


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "GalleryItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        activityIndicatorView.startAnimating()
        presenter.getGallery()
    }
}

extension GalleryCollectionViewController: GalleryPresenterView {
    
    func updateGallery() {
        title = galleryTitle
        collectionView.reloadData()
        activityIndicatorView.stopAnimating()
    }

    func presentAlert(with error: String) {
        activityIndicatorView.stopAnimating()
        showAlert(with: "\(error). Try again.") { [weak self] _ in
            guard let self = self else { return }
            self.activityIndicatorView.startAnimating()
            self.presenter.getGallery()
        }

    }
}

extension GalleryCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? ItemDetailViewController else { return }
        detailVC.slide = slides[indexPath.row]
        present(detailVC, animated: true, completion: nil)
    }
}

extension GalleryCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? GalleryItemCollectionViewCell else {
            return GalleryItemCollectionViewCell()
        }
        cell.item = slides[indexPath.row]
        return cell
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - 20)/2, height: 300)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
