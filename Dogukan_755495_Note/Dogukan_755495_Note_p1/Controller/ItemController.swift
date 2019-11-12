//
//  ItemController.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 10.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ItemController: UIViewController , UITableViewDelegate , UITableViewDataSource {
 

    @IBOutlet weak var tableView: UITableView!
    var itemsOfFolders = [[String]]()
    var incomingIndexFromViewController = 0 ;
    weak var itemTable: ViewController?
    var cellContent = "";
    var pushedRowIndex = 0;
    var incomingFolder : [String] = []
    var checkMarkedCellsIndexNumbers : [Int] = [];

 
    
    @IBOutlet weak var moveFolderButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
//    var groups = [[String]]()
    
    // we create three simple string arrays for testing
//    var groupB = ["Canada", "Mexico", "United States"]
//    var groupC = ["China", "Japan", "South Korea"]

    //groups.append(groupB)
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData();
//    }
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        moveFolderButton.isEnabled = false;
        deleteButton.isEnabled = false ;
        moveFolderButton.isOpaque = true ;
        deleteButton.isOpaque = true ;

        
        
        // Do any additional setup after loading the view.
       
    }
    

    
    //Change back button name to folders
//    override func viewDidAppear(_ animated: Bool) {
//
//        self.navigationController?.navigationBar.backItem?.title = "Folders"
//    }
    

    
 
    
    @IBAction func btnAddNewItem(_ sender: UIButton) {
        
    }
    
    
   
    @IBAction func btn_On_Off_Features(_ sender: UIBarButtonItem) {
        
        
        if( moveFolderButton.isEnabled == true){
            moveFolderButton.isEnabled = false;
            deleteButton.isEnabled = false ;
            moveFolderButton.isOpaque = true ;
            deleteButton.isOpaque = true ;
        }
        
        else{
            moveFolderButton.isEnabled = true;
            deleteButton.isEnabled = true
            moveFolderButton.isOpaque = false ;
            deleteButton.isOpaque = false ;
        }
        
        
    }
    
    
    @IBAction func btn_delete(_ sender: UIButton) {

       
       
        let cells = self.tableView.visibleCells;
        let iterateNumber = self.tableView.visibleCells.count;
        
        var counter = 0;
        var indexNum = 0;
    

        
        for i in stride(from: 0, to: iterateNumber,  by: 1 ){
          
            
            if(cells[i].accessoryType == .checkmark){
                
                cells[i].accessoryType = .detailButton
                //Otherwise due to decreasing size of an array it gives index out of range error
                indexNum = i-counter
               
                
                itemsOfFolders[incomingIndexFromViewController].remove(at: indexNum);
                counter += 1;
                
                
                //To delete cells manually
                //let indexPath = IndexPath(item: indexNum, section: 0)
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                
                
            }
        }
        
        tableView.reloadData();
        
    }
    
    
    //Save all items that added
    override func viewWillDisappear(_ animated: Bool) {
        itemTable!.itemsOfFolders = self.itemsOfFolders ;
        itemTable!.tableView.reloadData()
    }
    
    
    

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsOfFolders[self.incomingIndexFromViewController].count ;
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        cell.itemName.text = self.itemsOfFolders[incomingIndexFromViewController][indexPath.row]
        
              return cell ;
     }
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            
        if(segue.identifier == "itemDetail"){
               
           let vc = segue.destination as! ItemDetailViewController;

            vc.incomingIdentifier = "itemDetail"
            vc.incomingText = cellContent ;
            vc.incomingIndexPath = self.pushedRowIndex;
            vc.incomingIndexFromViewController = self.incomingIndexFromViewController;
            vc.itemsOfFolders = self.itemsOfFolders;
            vc.itemTableOfItemController = self ;
            
        }
    
    //Send the information of total cell number to itemdetailviewcontroller
    if(segue.identifier == "newItem"){
        
            let vc = segue.destination as! ItemDetailViewController;

            
        
            vc.incomingIdentifier = "newItem";
            vc.incomingIndexPath = itemsOfFolders[self.incomingIndexFromViewController].count-1
            vc.incomingIndexFromViewController = self.incomingIndexFromViewController;
            vc.itemsOfFolders = self.itemsOfFolders;
            vc.itemTableOfItemController = self ;
        
        //For initial item
        if(vc.incomingIndexPath == -1){
            vc.incomingIndexPath = 0
            }
        
        }
    
        
        if(segue.identifier == "popUpFolderPage"){
            
            let vc = segue.destination as! FolderChooserViewController;
            vc.incomingFolder = self.incomingFolder;
            vc.incomingItemIndexes = self.checkMarkedCellsIndexNumbers;
            vc.incomingFolderIndex = self.incomingIndexFromViewController ;
            vc.itemsOfFolders = self.itemsOfFolders
            vc.itemController = self;
            
        }

    
}
    
    
    //Accessory Detail Button
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        cellContent = self.itemsOfFolders[incomingIndexFromViewController][indexPath.row]
        pushedRowIndex = indexPath.row;
        
        performSegue(withIdentifier: "itemDetail", sender: nil )
        
        
    }
    
    
    
    @IBAction func checkmarkButton(_ sender: UIButton) {
        
        //Set cell chosen
        let cell = sender.superview?.superview as! ItemTableViewCell

        
        if(cell.accessoryType == .detailButton){
            cell.accessoryType = .checkmark
        }
        
        else{
            cell.accessoryType = .detailButton;
        }
        
    }
    

    @IBAction func moveItemToFolderButton(_ sender: UIButton) {
        
        let cells = self.tableView.visibleCells;
        let iterateNumber = self.tableView.visibleCells.count;
        
        
        
        
        for i in stride(from: 0, to: iterateNumber,  by: 1 ){
          
            
            if(cells[i].accessoryType == .checkmark){

                
                checkMarkedCellsIndexNumbers.append(i);
                
                
            }
        }
        
        
        performSegue(withIdentifier: "popUpFolderPage", sender: nil);
    }
    

}
