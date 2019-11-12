//
//  FolderChooserViewController.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 11.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class FolderChooserViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
 
    
    
    @IBOutlet weak var tableView: UITableView!
    var incomingFolder : [String] = [] ;
    var incomingItemIndexes : [Int] = [] ;
    var incomingFolderIndex = 0 ;
    var itemsOfFolders = [[String]]()
    
     weak var itemController: ItemController?
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    


    @IBAction func moveItemButton(_ sender: UIButton) {
        
        let cell = sender.superview?.superview as! PopUpFolderTableViewCell
        let indexPath = self.tableView.indexPath(for: cell);
        let index = (indexPath?.row)! ;
        
        
        let alert = UIAlertController(title: "Move to \(cell.folderName.text!)", message: "Are you sure?", preferredStyle: .alert);
        
        let actionNo = UIAlertAction(title: "No", style: .default) { (actionNo) in
            self.itemController?.tableView.reloadData();
            alert.dismiss(animated: true, completion: nil);
        }
        
        
        let actionMove = UIAlertAction(title: "Move", style: .default) { (actionMove) in
            
            var counter = 0;
            
            
            for i in stride(from: 0, to: self.incomingItemIndexes.count, by: 1){
            
                
                self.itemsOfFolders[index].append(self.itemsOfFolders[self.incomingFolderIndex][self.incomingItemIndexes[i]-counter])
                self.itemsOfFolders[self.incomingFolderIndex].remove(at: self.incomingItemIndexes[i] - counter);

                
                counter += 1;
            
            }
            
            self.itemController?.itemsOfFolders = self.itemsOfFolders ;
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        actionNo.setValue(UIColor.orange, forKey: "titleTextColor");
        alert.addAction(actionNo);
        alert.addAction(actionMove);
        
        
        present(alert, animated: true, completion: nil);
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingFolder.count;
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "folder", for: indexPath) as! PopUpFolderTableViewCell
        
        cell.folderName.text = incomingFolder[indexPath.row];
        
        return cell;
     }
    
    override func viewWillDisappear(_ animated: Bool) {
        itemController?.tableView.reloadData();
    }
}
