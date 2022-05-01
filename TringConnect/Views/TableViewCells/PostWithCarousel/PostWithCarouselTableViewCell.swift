//
//  PostWithCarouselTableViewCell.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class PostWithCarouselTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var course: [Course] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDataSource() {
        course = loadJson(filename: "Course") ?? []
    }
    
    func loadJson(filename fileName: String) -> [Course]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseDataItem.self, from: data)
                return jsonData.course
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    private func registerNib() {
        let nib = UINib(nibName: TCConstant.kNibNameCarousel, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: TCConstant.kCarouselReusableIdentifier)
    }
    
}

extension PostWithCarouselTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCConstant.kCarouselReusableIdentifier, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        let eventItem = course[indexPath.row] as Course
        cell.setupDataSource(eventItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return course.count
    }
}

extension PostWithCarouselTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 187.0, height: 270.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 24, left: 6, bottom: 24, right: 6)
    }
}
