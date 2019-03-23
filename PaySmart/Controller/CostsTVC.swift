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

    var costs:[Cost] = []
    
    private func fetchDataTable(){

        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Cost>(entityName: "Cost")
        
        do{
            let fetch = try context.fetch(fetchRequset)
            
            self.costs = fetch
            self.delegate?.didAddCosts(costs: fetch)
            self.delegate?.fetchCost()
            
           } catch let fetchErr {
            print("failed, when tried to fetch \(fetchErr)")
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataTable()
        
            tableView.backgroundView?.backgroundColor = UIColor.clear
            view.backgroundColor = UIColor.lightGray
        
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
    }

    // MARK: - Table view data source

    @IBAction func addItem(_ sender: Any) {
        addAlert()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = costs.count
        return count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "costCell", for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "costCell")
        let cost = costs[indexPath.row].cost
        let name = costs[indexPath.row].name 
        cell.textLabel?.text = name
        cell.backgroundColor = UIColor.clear
        
        cell.detailTextLabel?.text = "\(cost)"
        cell.detailTextLabel?.textColor = UIColor.green
        
        return cell
    }
    
    func addAlert(){
        let alert = UIAlertController(title: "Add Cost", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (text) in
            text.placeholder = "Name Of Cost"
        }
        alert.addTextField { (text) in
            text.placeholder = "Costs"
            text.keyboardType = .numberPad
        }
        
        
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
          
       
            
            let context = CoreDataManager.shared.persistentContiner.viewContext
            
            let cost = NSEntityDescription.insertNewObject(forEntityName: "Cost", into: context)
            
            cost.setValue(Int(alert.textFields![1].text!), forKey: "cost")
            cost.setValue(alert.textFields![0].text, forKey: "name")
            
            
            
            // save context
            
            do{
                try context.save()
                self.costs.append(cost as! Cost)
                self.tableView.reloadData()
                
            } catch let saveErr{
                print("Failed to save \(saveErr)")
            }
        }
           
           

        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func checkCosts() {
        
    }
   
}
