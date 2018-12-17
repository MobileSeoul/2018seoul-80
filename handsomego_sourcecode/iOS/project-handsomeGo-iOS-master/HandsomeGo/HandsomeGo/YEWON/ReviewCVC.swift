//
//  ReviewCVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import UIKit

class ReviewCVC: UICollectionViewCell {

    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewComment: UILabel!
    
    @IBOutlet var starImg: [UIImageView]!
    @IBOutlet var photoImg: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for i in 0...3{
            photoImg[i].layer.cornerRadius = 5
            photoImg[i].layer.masksToBounds = true
            
        }
    }
    
}
