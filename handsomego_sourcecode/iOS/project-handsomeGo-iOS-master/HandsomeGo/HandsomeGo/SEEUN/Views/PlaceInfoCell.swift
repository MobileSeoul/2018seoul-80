//
//  PlaceInfoCell.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class PlaceInfoCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reviewCntLabel: UILabel!
    @IBOutlet weak var colorBar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
}
