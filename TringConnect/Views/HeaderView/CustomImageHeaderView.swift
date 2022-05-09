//
//  CustomImageHeaderView.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class CustomImageHeaderView: UIView {

    @IBOutlet weak var hastagTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    let nibName = "CustomImageHeaderView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
    }
    
    func setupDataSource(_ person: PersonDetails) {
        role.text = person.role
        descriptionTxt.text = person.post
        titleName.text = person.name
    }

}
