//
//  CoreDataManager.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/23/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let persistentContiner:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PaySmart")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error{
                fatalError("Loading of stroe Failed with \(error)")
            }
        }
        
        
        return container
    }()
    
    
}
