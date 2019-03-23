//
//  ExtensoinForInfoVC.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension InfoViewController{
    
    
    
    // func that provided by delegate ta show the changes with balance on the labels
    func didAddCosts() {
        
        self.costsBtnLabel.setTitle("Costs: \(self.costToString())", for: .normal)
        self.currentBtnLabel.setTitle("Current: \(self.currentBalance())", for: .normal)
        print("Did add cost func")
    }
    
    
    
    // func to convert DUouble to String
    func costToString() -> String{
        return "\(currentCostsSum())"
    }
    // func to calculate current value and convert it to string
    func currentBalance() -> String{
        let cost = currentCostsSum()
        guard var incomes = wallet?[0].income else { return "0.0"}
        wallet?.forEach({ (income) in
            incomes += income.income
            print(incomes)
        })
        // guard let income = self.wallet?[0].income else {return "0.0"}
        let current = "\(incomes - cost)"
        
        return current
    }
    // func to calculet all costs
    func currentCostsSum() -> Double{
        var costsSum: Double = 0.0
        costs.forEach { (cost) in
            costsSum += cost.cost
        }
        return costsSum
    }
    
    // alert to add income to view and core data
    func incomeAlert(){
        let ac = UIAlertController(title: "Add", message: "if you wan to minus just add \"-\" on the beginning ", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let text = ac.textFields?.first?.text else {return}
            self.saveIncomToCoreData(text: text)
            self.didAddCosts()
        }
        ac.addTextField { (text) in
            text.placeholder = "Add cost here"
            text.keyboardType = .asciiCapableNumberPad
        }
        ac.addAction(action)
        present(ac, animated: true, completion: nil)
        
    }
    
    
    // saving and updating data in wallet
    func saveIncomToCoreData(text: String){
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        
        let wallet = NSEntityDescription.insertNewObject(forEntityName: "Wallet", into: context) as! Wallet
        
        
        wallet.setValue(Double(text)!, forKey: "income")
        
        
        do{
            try context.save()
            self.wallet?.append(wallet)
        } catch let saveIncErr{
            print("Failed to save income \(saveIncErr)")
        }
    }
    
    // func to fetch wallet from Core Data
    func fetchDataIncome(){
        
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Wallet>(entityName: "Wallet")
        
        
        do{
            let wallets = try context.fetch(fetchRequset)
            if wallets.isEmpty{
                self.incomeAlert()
            } else {
                
                self.wallet = wallets
            }
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
        
        
    }
    // func to fetch cost from Core Data
    func fetchCost(){
        
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Cost>(entityName: "Cost")
        
        do{
            let fetch = try context.fetch(fetchRequset)
            self.costs = fetch
            
            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
    }
    
    
}
