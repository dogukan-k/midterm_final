//
//  ItemTableViewCell.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 11.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {


    @IBOutlet weak var itemName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
