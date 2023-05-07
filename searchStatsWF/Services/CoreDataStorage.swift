//
//  CoreDataStorage.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 13.03.2022.
//

import Foundation
import CoreData

final class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    
    private init() {}
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "searchStatsWF")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Restore from Persistent Storage
    func fetchData(completion: (Result<[FavoriteObject], Error>) -> Void) {
        let fetchRequest = FavoriteObject.fetchRequest()
        
        do {
            let stats = try viewContext.fetch(fetchRequest)
            completion(.success(stats))
        } catch let error {
            completion(.failure(error))
        }
    }
    //Add new player to storage
    func save(_ newPlayer: FavouritePlayer) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavoriteObject", in: viewContext) else { return }
        guard let object = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? FavoriteObject else { return }
        object.nickName = newPlayer.nickName
        object.clanName = newPlayer.clanName
        object.rankImage = Int16(newPlayer.rankImage ?? 0)
        saveContext()
    }
    //Delete player from storage
    func delete(_ player: FavoriteObject) {
        viewContext.delete(player)
        saveContext()
    }
    
    //Check if player added to favorite
    func isItemFavorite(_ player: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteObject")
        fetchRequest.predicate = NSPredicate(format: "nickName == %@", player)
        return ((try? viewContext.count(for: fetchRequest)) ?? 0) > 0
    }
}


