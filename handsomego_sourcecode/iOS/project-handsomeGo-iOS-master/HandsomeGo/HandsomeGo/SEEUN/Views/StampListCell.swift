//
//  StampListCell.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 14..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class StampListCell: UITableViewCell {

    @IBOutlet weak var stampCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var stampImage: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stampCollectionView.delegate = self
        stampCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension StampListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stampCollectionView.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath) as! StampCell
        cell.stampImageView.image = stampImage[indexPath.item]
        return cell
        
    }
    
    
}
