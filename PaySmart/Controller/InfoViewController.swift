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
    
    func didAddCosts() {
        //self.costsBtnLabel.setTitle(self.costToString(), for: .normal)
        self.costsBtnLabel.setTitle(self.costToString(), for: .normal)
        self.currentBtnLabel.setTitle(self.currentBalance(), for: .normal)
        print("sdfgbkhjgvhcfgxhgdcfhgvjhfgxc")
    }
   
    
   
//    var incomes = 0.0
    var costs:[Cost] = []
    
    var wallet: Wallet? {
        didSet{
            self.didAddCosts()
        }
    }
    
    @IBOutlet weak var incomeBtnLabel: Button!
    @IBOutlet weak var costsBtnLabel: Button!
    @IBOutlet weak var currentBtnLabel: Button!
    @IBOutlet weak var addCostsBtnLbl: Button!
    
    
    
    func fetchDataIncome(){
      
        let context = CoreDataManager.shared.persistentContiner.viewContext
        
        let fetchRequset = NSFetchRequest<Wallet>(entityName: "Wallet")
        
        
        do{
            let wallets = try context.fetch(fetchRequset)
            if wallets.isEmpty{
                self.incomeAlert()
            } else {
            self.wallet = wallets[0]
            }

            
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

            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fetchCost()
        didAddCosts()
        fetchDataIncome()

    }



    

    @IBAction func incomeButton(_ sender: Any) {
     
        incomeAlert()
        
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "costsSegue"{
            let costVC = segue.destination as! CostsTVC
            costVC.delegate = self
            costVC.costs = self.costs
        }
    }
    func costToString() -> String{
     return "\(currentCostsSum())"
    }
    
    func currentBalance() -> String{
        let cost = currentCostsSum()
        guard let income = self.wallet?.income else {return "0.0"}
        let current = "\(income - cost)"
        
        return current
    }
    
    func currentCostsSum() -> Double{
        var costsSum: Double = 0.0
        costs.forEach { (cost) in
            costsSum += cost.cost
        }
        return costsSum
    }
    
    func incomeAlert(){
        let ac = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let text = ac.textFields?.first?.text else {return}
            
            let context = CoreDataManager.shared.persistentContiner.viewContext
            
            let wallet = NSEntityDescription.insertNewObject(forEntityName: "Wallet", into: context)
            
            
            wallet.setValue(Double(text)!, forKey: "income")
            
            
            do{
                try context.save()
                self.wallet = (wallet as! Wallet)
            } catch let saveIncErr{
                print("Failed to save income \(saveIncErr)")
            }
            
            self.costsBtnLabel.setTitle(self.costToString(), for: .normal)
            self.currentBtnLabel.setTitle(self.currentBalance(), for: .normal)
           
            
            
        }
        ac.addTextField { (text) in
            text.placeholder = "Add cost here"
            text.keyboardType = .numberPad
        }
        ac.addAction(action)
        present(ac, animated: true
            , completion: nil)
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
         print(costs.count)
        fetchCost()
        didAddCosts()
    }

}
