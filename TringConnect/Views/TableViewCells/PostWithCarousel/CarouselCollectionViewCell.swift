//
//  CarouselCollectionViewCell.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CarouselCardView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDataSource(_ course: Course) {
        cardView.setupDataSource(course)
    }

}
