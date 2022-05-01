//
//  CarouselCardView.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class CarouselCardView: UIView {

    @IBOutlet weak var favouriteBtn: UIButton!
    let nibName = "CarouselCardView"
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
    }
    
    func setupDataSource(_ course: Course) {
        titleName.text = course.name
        imageView.image = UIImage(named: course.image)
    }

    @IBAction func favouriteTapAction(_ sender: Any) {
        favouriteBtn.isSelected = !favouriteBtn.isSelected
        let imageName = favouriteBtn.isSelected ? "heart_select" : "heart_unselect"
        favouriteBtn.setImage(UIImage(named: imageName), for: .normal)
    }
}
