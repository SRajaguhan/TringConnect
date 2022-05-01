//
//  PostWithButtonView.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class PostWithButtonView: UIView {

    let nibName = "PostWithButtonView"
    
    @IBOutlet weak var knowbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
        setupButton()
    }
    
    func setupButton() {
        knowbutton.layer.borderColor = UIColor(named: "Green")?.cgColor
        knowbutton.layer.borderWidth = 1.0
        knowbutton.backgroundColor  = .clear
    }

}
