//
//  EventsTableViewCell.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    static let kNibName = "EventsCollectionViewCell"
    static let kReusableIdentifier = "eventsCollectionViewIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    var events: [Events] = []
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
        events = loadJson(filename: "Events") ?? []
    }
    
    func loadJson(filename fileName: String) -> [Events]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.event
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    private func registerNib() {
        let nib = UINib(nibName: EventsTableViewCell.kNibName, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: EventsTableViewCell.kReusableIdentifier)
    }
    
}

extension EventsTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsTableViewCell.kReusableIdentifier, for: indexPath) as? EventsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let eventItem = events[indexPath.row] as Events
        eventCell.eventsImage.image = UIImage(named:eventItem.image)
        eventCell.eventTitle.text = eventItem.name
        return eventCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
}

extension EventsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 60.0, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 24, left: 6, bottom: 24, right: 6)
    }
}
