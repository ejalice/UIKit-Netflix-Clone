//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/18.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        // item -> Stored in Core Data
        let item = TitleItem(context: context)
        
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
            print(error.localizedDescription)
        }
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result <[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
            print("FAILED Getting Request from Database")
        }
        
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model) // Ask DataBase Manager Delete certain Object
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
