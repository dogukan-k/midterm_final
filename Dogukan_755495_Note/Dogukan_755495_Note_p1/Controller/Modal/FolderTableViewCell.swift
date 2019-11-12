//
//  FolderTableViewCell.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 9.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

   
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var labelCountItems: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }
    
}
