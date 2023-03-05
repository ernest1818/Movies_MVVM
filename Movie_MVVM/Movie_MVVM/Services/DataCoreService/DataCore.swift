// DataCore.swift
// Copyright © Avagyan Ernest. All rights reserved.

import CoreData
import Foundation

/// Кор дата
final class DataCore {
    // MARK: - Public Properties

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Private Properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error)")
            }
        }
        return container
    }()

    // MARK: - Public Method

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
