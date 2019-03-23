//
//  ExtensionForCostTVC.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension CostsTVC{
    
    // func to add data to tableView
    
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

            guard let costName = alert.textFields![0].text else {return}
            guard let costPrice = alert.textFields![1].text else {return}
            
            self.saveCost(name: costName, sum: costPrice)
          }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // func to save the costs in Core Data
    func saveCost(name: String, sum: String){

        let context = CoreDataManager.shared.persistentContiner.viewContext


        let cost = NSEntityDescription.insertNewObject(forEntityName: "Cost", into: context) as! Cost

        cost.setValue(Int(sum), forKey: "cost")
        cost.setValue(name, forKey: "name")

        // save context

        do{
            try context.save()
            self.costs?.append(cost)
            self.tableView.reloadData()
            
        } catch let saveErr{
            print("Failed to save \(saveErr)")
        }
    }


    


}
