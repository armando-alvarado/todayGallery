//
//  ItemDetailViewController.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var slide: Slide?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        guard let item = slide else { return }
        titlelabel.text = item.caption
        authorLabel.text = item.credit
        dateLabel.text = item.date
        imageView.loadImage(urlString: "\(item.publishUrl)\(item.smallBaseName)")
    }

    @IBAction func onCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
