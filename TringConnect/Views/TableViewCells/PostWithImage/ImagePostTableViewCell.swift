//
//  ImagePostTableViewCell.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

protocol TCNaviagtiondelegate: NSObjectProtocol {
    func presentViewControllerFromCell(image: UIImage)
    func presentViewControllerFromCell(imageArray: [String], index: Int)
}

class ImagePostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    weak var navigationDelegate: TCNaviagtiondelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addGesture()
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        postImageView.addGestureRecognizer(tap)
        postImageView.isUserInteractionEnabled = true
    }

    func setupDataSource(index: Int) {
        let imageName = (index == 1) ? "post_img" : "post_one_img"
        postImageView.image = UIImage(named: imageName)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        navigationDelegate?.presentViewControllerFromCell(image: postImageView.image ?? UIImage())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
