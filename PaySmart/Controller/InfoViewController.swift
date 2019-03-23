//
//  InfoViewController.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController, CostModelDelegate {
    
    func didAddCosts(costs: [Cost]) {
        self.costs = costs
    }
   
    
   
    var incomes = 0.0
    var costs:[Cost] = []
    
    
    @IBOutlet weak var incomeBtnLabel: Button!
    @IBOutlet weak var costsBtnLabel: Button!
    @IBOutlet weak var currentBtnLabel: Button!
    @IBOutlet weak var addCostsBtnLbl: Button!
    
    
    
    func fetchDataIncome(){
      
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Wallet>(entityName: "Wallet")
        
        
        do{
            let fetch = try context.fetch(fetchRequset)
            
            self.incomes += fetch[0].income
//            fetch.forEach { (income) in
//                incomes = income.income
//            }
            //self.incomes = fetch[0].income
            //self.incomeBtnLabel.setTitle("Income: \(incomes)", for: .normal)
            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
        
        
    }
    
    func fetchCost(){
        
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Cost>(entityName: "Cost")
        
        
        do{
            let fetch = try context.fetch(fetchRequset)
            self.costs = fetch
            self.costsBtnLabel.setTitle(self.costToString(), for: .normal)
            self.currentBtnLabel.setTitle(self.currentBalance(), for: .normal)
            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchDataIncome()
        
        fetchCost()
       
    }



    

    @IBAction func incomeButton(_ sender: Any) {
       
        
        let ac = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let text = ac.textFields?.first?.text else {return}
            
           let context = CoreDataManager.shared.persistentContiner.viewContext
            
            let wallet = NSEntityDescription.insertNewObject(forEntityName: "Wallet", into: context)
            
            
              wallet.setValue(Double(text)!, forKey: "income")
            
            
            do{
                try context.save()
                
            } catch let saveIncErr{
                print("Failed to save income \(saveIncErr)")
            }
            
            self.fetchDataIncome()
            
            self.fetchCost()
            
            self.addCostsBtnLbl.isEnabled = true
            
            
        }
        ac.addTextField { (text) in
            text.placeholder = "Add cost here"
            text.keyboardType = .numberPad
        }
        ac.addAction(action)
        present(ac, animated: true
            , completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "costsSegue"{
            let costVC = segue.destination as! CostsTVC
            costVC.delegate = self
        }
    }
    func costToString() -> String{
        var costsText = " "
        var costDouble = 0.0
        
       let count = costs.count
        print(count)
        for i in 0..<count{
            costDouble += costs[i].cost
        }
        costsText = "\(costDouble)"
     return costsText
    }
    func currentBalance() -> String{
        guard let cost = Double(self.costToString()) else {return "0.0"}
        let current = "\(incomes - cost)"
        
        return current
    }
    
    
  

}
