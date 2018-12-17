//
//  RankCell.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 10..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class RankCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        colorView.layer.cornerRadius = 3
        colorView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
