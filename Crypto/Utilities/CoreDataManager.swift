//
//  CoreDataManager.swift
//  Crypto
//
//  Created by qwotic on 15.02.2023.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "PaymentModel")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
