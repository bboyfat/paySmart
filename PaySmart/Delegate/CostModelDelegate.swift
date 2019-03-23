//
//  CostsModelDelagate.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/15/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


protocol CostModelDelegate{
    func didAddCosts(costs: [Cost])
    func fetchCost()
}
