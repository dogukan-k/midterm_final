//
//  ViewController.swift
//  Dogukan_755495_Note_p1
//
//  Created by DKU on 9.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    
    
   // var folder : [String]? ;
    var folder : [String] = [] ;
    var itemsOfFolders = [[String]]()
    @IBOutlet weak var tableView: UITableView!
    var pushedRowIndex = 0;
    

    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
       
        
     }
    


    
    
    

    
    //Edit function enable/disable
    @IBAction func btn_Edit(_ sender: UIBarButtonItem) {
        
        self.tableView.isEditing = !self.tableView.isEditing
        
        if(self.tableView.isEditing == true){
            sender.title = "Done" ;
        }
        
        else{
            sender.title = "Edit" ;
        }
        
    }
    
    
    
    //Add new Folder
    @IBAction func btn_Add_Folder(_ sender: UIButton) {
               
                    var textField = UITextField();
        
                    let alert = UIAlertController(title: "New Folfer", message: "Enter a name for this folder", preferredStyle: .alert);
                    let alertTakenFolder = UIAlertController(title: "Name Taken", message: "Please choose a different name", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                        //If it is empty do nothing
                        if(textField.text == ""){
                         
                            
                        }
                        //If there is no repeated folder name add new folder
                        else if(self.folder.contains(textField.text!) == false){
                            self.folder.append(textField.text!);
                            self.tableView.reloadData();
                                                     
                                                     
                            //Create array of items , then we will set contents at other page.
                            let items : [String] = [] ;
                            self.itemsOfFolders.append(items);
                        }
                        
                        //If folder name exist , show an alert
                        else{
                            
                            alert.dismiss(animated: false, completion: nil)
                            let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
                                alertTakenFolder.dismiss(animated: true, completion: nil) ;
                            }
                            alertTakenFolder.addAction(okAction);
                            okAction.setValue(UIColor.orange, forKey: "titleTextColor")
                            self.present(alertTakenFolder, animated: true, completion: nil);
                        }
                     
        
                    }
        
                    action.setValue(UIColor.black , forKey: "titleTextColor")
        
        
                    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
                        alert.dismiss(animated: true, completion: nil);
                    }
                    
                    cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
                    
                    alert.addAction(cancelAction)
                    alert.addAction(action);
                   
                    alert.addTextField { (field) in
                        textField = field ;
                        textField.placeholder = "Name"
        
                    }
        
                    present(alert, animated: true, completion: nil);
       
      
                
        

    }
    
    //ViewController'in arasina navigation controller girince , once yuvarlak icindeki kareden gitmek istedigin view'e segue veriyorsun identifier ile
    //daha sonra ayni yerden navigation controllera segue veriyorsun sadece show ile , identifier'a gerek yok.
    @IBAction func btn_Item_Controller_Direction(_ sender: UIButton) {
      
        let cell = sender.superview?.superview as! FolderTableViewCell
               let indexPath = self.tableView.indexPath(for: cell);
               let index = indexPath?.row ;
               pushedRowIndex = index! ;
        performSegue(withIdentifier: "items", sender: nil)
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "items"){
            
            let vc = segue.destination as! ItemController;
            vc.itemsOfFolders = self.itemsOfFolders ;
            vc.incomingIndexFromViewController = self.pushedRowIndex ;
            vc.itemTable = self ;
            vc.incomingFolder = folder ;
            
        }
    }

    
    
    //
    //To disable bar_button automatic delete function
    //
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
          return .none
      }
      func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
          return false
      }
    
    //
    //To disable bar_button automatic delete function
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! FolderTableViewCell
    
        cell.folderName.text = folder[indexPath.row];
        cell.labelCountItems.text = String(itemsOfFolders[indexPath.row].count);
        
        return cell ;
    }
    
    
    
    //to move folders
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedFolder = self.folder[sourceIndexPath.row]
        let movedItemsOfFolder = self.itemsOfFolders[sourceIndexPath.row]
        folder.remove(at: sourceIndexPath.row);
        folder.insert(movedFolder, at: destinationIndexPath.row);
        
        //Content of folders should also be rearranged according to indexpath
        itemsOfFolders.remove(at: sourceIndexPath.row);
        itemsOfFolders.insert(movedItemsOfFolder, at: destinationIndexPath.row);
       
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
               let deleteRow = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
                self.folder.remove(at: indexPath.row)
                self.itemsOfFolders.remove(at: indexPath.row);
                tableView.deleteRows(at: [indexPath], with: .automatic)
              
               })
              

               return UISwipeActionsConfiguration(actions: [deleteRow])
           }
    
    
}

