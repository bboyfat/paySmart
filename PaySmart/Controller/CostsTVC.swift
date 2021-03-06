//
//  CostsTVC.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/13/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import CoreData

class CostsTVC: UITableViewController {
    
    
    var delegate: CostModelDelegate?

    var costs:[Cost]?
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
            tableView.backgroundView?.backgroundColor = UIColor.clear
            view.backgroundColor = UIColor.lightGray
        
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBAction func addItem(_ sender: Any) {
        addAlert()
        print("addAlert is not working")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = costs?.count else { return 0}
        return count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "costCell", for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "costCell")
        guard let cost = costs?[indexPath.row].cost else { return cell }
        guard let name = costs?[indexPath.row].name else { return cell }
        cell.textLabel?.text = name
        cell.backgroundColor = UIColor.clear
        
        cell.detailTextLabel?.text = "\(cost)"
        cell.detailTextLabel?.textColor = UIColor.green
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            guard let cost = self.costs?[indexPath.row] else { return }
            // deleting from table view
            self.costs?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            // delete from Core Data
            
            let context = CoreDataManager.shared.persistentContiner.viewContext
            context.delete(cost)
            do{
                try context.save()
            } catch {
                print("Failed when trying to save after deleting")
            }
        }
        
        return [deleteAction]
    }
    
//    func addAlert(){
//        let alert = UIAlertController(title: "Add Cost", message: nil, preferredStyle: .alert)
//        
//        alert.addTextField { (text) in
//            text.placeholder = "Name Of Cost"
//        }
//        alert.addTextField { (text) in
//            text.placeholder = "Costs"
//            text.keyboardType = .numberPad
//        }
//        
//        
//        
//        let action = UIAlertAction(title: "OK", style: .default) { (action) in
//          
//       
//            
//            let context = CoreDataManager.shared.persistentContiner.viewContext
//            
//
//            let cost = NSEntityDescription.insertNewObject(forEntityName: "Cost", into: context) as! Cost
//            
//            cost.setValue(Int(alert.textFields![1].text!), forKey: "cost")
//            cost.setValue(alert.textFields![0].text, forKey: "name")
//            
//            
//            
//            // save context
//            
//            do{
//                try context.save()
//                self.costs?.append(cost)
//                
////                self.delegate?.fetchCost()
//                self.tableView.reloadData()
////                self.delegate?.didAddCosts()
//            } catch let saveErr{
//                print("Failed to save \(saveErr)")
//            }
//        }
//           
//           
//
//        
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.delegate?.fetchCost()
    }
    
    
}
