//
//  HistoryItemTableViewCell.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/30/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class HistoryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var restaurantDescription: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var code: UILabel!
    
    @IBOutlet weak var cancelBooking: UIButton!
    @IBOutlet weak var postpone: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        restaurantDescription.backgroundColor = Color.TBBackground
        restaurantName.backgroundColor = Color.TBBackground
        code.backgroundColor = Color.TBBackground
        cancelBooking.tintColor = Color.TBBackground
        cancelBooking.backgroundColor = Color.TBGreen
        postpone.tintColor = Color.TBBackground
        postpone.backgroundColor = Color.TBGreen
        backgroundColor = Color.TBBackground
        imageItem.layer.cornerRadius = imageItem.frame.size.width / 2;
        imageItem.clipsToBounds = true;
        imageItem.image = UIImage(named: "restaurant-test")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
