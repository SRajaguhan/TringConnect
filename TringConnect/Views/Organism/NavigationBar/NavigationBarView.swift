//
//  NavigationBarView.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class NavigationBarView: UIView {

    let nibName = "NavigationBarView"
    let badgeSize: CGFloat = 10
    let badgeTag = 100
    
    @IBOutlet weak var notificationsButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
        showBadge()
    }
    
    func badgeLabel() -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.backgroundColor = .systemRed
        return badgeCount
    }
    
    @IBAction func notificationsButtonTapAction(_ sender: Any) {
        removeBadge()
    }
    
    func showBadge() {
        let badge = badgeLabel()
        notificationsButton.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: notificationsButton.leftAnchor, constant: 14),
            badge.topAnchor.constraint(equalTo: notificationsButton.topAnchor, constant: 0),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }
    
    func removeBadge() {
        if let badge = notificationsButton.viewWithTag(badgeTag) {
            badge.removeFromSuperview()
        }
    }
}
