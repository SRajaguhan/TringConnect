//
//  PostWithCollageTableViewCell.swift
//  TringConnect
//
//  Created by Apple on 02/05/22.
//

import UIKit

class PostWithCollageTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var postImages: [String]  = ["Image_one","Image_two","Image_three","Image_four"]
    weak var navigationDelegate: TCNaviagtiondelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerNib() {
        let nib = UINib(nibName: TCConstant.kImageCollectionViewCell, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: TCConstant.kImageCollectionViewCellIdentifier)
    }
    
}

extension PostWithCollageTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: TCConstant.kImageCollectionViewCellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = postImages[indexPath.row]
        eventCell.setupImage(name: imageName)
        return eventCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
}

extension PostWithCollageTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationDelegate?.presentViewControllerFromCell(imageArray: postImages, index: indexPath.row)
    }
}

extension PostWithCollageTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 2
        let height:CGFloat = (collectionView.frame.size.height - space) / 2.0
        let width:CGFloat = (collectionView.frame.size.width - 20) / 2.0
        return CGSize(width: width, height: height)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return  UIEdgeInsets(top: 24, left: 6, bottom: 24, right: 6)
//    }
}
