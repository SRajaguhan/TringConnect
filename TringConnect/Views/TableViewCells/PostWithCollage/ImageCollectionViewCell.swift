//
//  ImageCollectionViewCell.swift
//  TringConnect
//
//  Created by Apple on 02/05/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupImage(name: String) {
        photoImageView.image = UIImage(named: name)
    }
}
