//
//  DrikkeTableViewCell.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 31.10.2018.
//  Copyright © 2018 øl. All rights reserved.
//

import UIKit

class DrikkeTableViewCell: UITableViewCell {
    @IBOutlet var liter: UILabel!
    @IBOutlet var literSlider: slider!
    
    @IBOutlet var prosent: UILabel!
    @IBOutlet var prosentSlider: slider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
