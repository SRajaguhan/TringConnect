//
//  EventsCollectionViewCell.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
       didSet{
           UIView.animate(withDuration: 0.25) {
               self.backgroundColor = UIColor(named: self.isSelected ? "Green" : "White")
           }
       }
   }

}
