//
//  CommentView.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class CommentView: UIView {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var likeDescriptionTxt: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var favouriteCount: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    let nibName = "CommentView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
    }

    @IBAction func commentsTapAction(_ sender: Any) {
    }
    
    @IBAction func favouriteTapAction(_ sender: Any) {
        favouriteBtn.isSelected = !favouriteBtn.isSelected
        let imageName = favouriteBtn.isSelected ? "heart_red_icon" : "heart_grey_icon"
        favouriteBtn.setImage(UIImage(named: imageName), for: .normal)
        let count = Int(favouriteCount.text ?? "") ?? 0
        favouriteCount.text = favouriteBtn.isSelected ? String(count + 1) : String(count - 1)
    }
}
