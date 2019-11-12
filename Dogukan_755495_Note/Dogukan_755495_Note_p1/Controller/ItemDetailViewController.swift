//
//  ItemDetailViewController.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 11.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var incomingText = "" ;
    var incomingIndexPath = 0 ;
    var incomingIndexFromViewController = 0;
    var itemsOfFolders = [[String]]();
    var incomingIdentifier = "" ;
    
    weak var itemTableOfItemController: ItemController?
    
    @IBOutlet weak var textItem: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textItem.text = incomingText ;
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //IF that page opened through detail accessory
        if(incomingIdentifier == "itemDetail"){
            
            itemsOfFolders[incomingIndexFromViewController][incomingIndexPath] = textItem.text!
            itemTableOfItemController?.itemsOfFolders = self.itemsOfFolders ;
            itemTableOfItemController?.tableView.reloadData();
        }
            
        //If that page opened with add new item button
        else if(incomingIdentifier == "newItem"){
            
            if(textItem.text != ""){
                
                itemsOfFolders[incomingIndexFromViewController].append(textItem.text!)
                         itemTableOfItemController?.itemsOfFolders = self.itemsOfFolders ;
                         itemTableOfItemController?.tableView.reloadData();
            }
            
         
        }

    }
    

}
