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
    
    
   
//    var incomes = 0.0
    var costs:[Cost] = []
    
    var wallet: [Wallet]?
    
    @IBOutlet weak var incomeBtnLabel: Button!
    @IBOutlet weak var costsBtnLabel: Button!
    @IBOutlet weak var currentBtnLabel: Button!
    @IBOutlet weak var addCostsBtnLbl: Button!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchCost()
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

  
    override func viewDidAppear(_ animated: Bool) {
         print(costs.count)

           didAddCosts()
    }

}


