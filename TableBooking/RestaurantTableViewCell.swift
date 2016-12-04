//
//  RestaurantTableViewCell.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/19/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var restImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = Color.TBBackground
        restImage.layer.cornerRadius = restImage.frame.size.width / 2;
        restImage.clipsToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
