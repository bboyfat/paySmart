//
//  Alert.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    private init(){}
    
    static func addAlert(title: String?, massage: String?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (acyion) in
            
        }
        
        alert.addTextField { (text) in
            text.placeholder = "Type your income here"
            text.keyboardType = .numberPad
        }
        alert.addAction(action)
        return alert
    }
    
}
