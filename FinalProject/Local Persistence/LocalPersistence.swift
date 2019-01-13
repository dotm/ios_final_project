//
//  LocalPersistence.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 13/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import CoreData

enum LocalPersistence {
    static let PERSISTENT_CONTAINER_NAME = "DataModel"
    
    static let QUIZ_CATEGORY_ENTITY = "QuizCategoryEntity"
    static let QUIZ_CATEGORY_NAME = "name"
    
    static let QUIZ_SCORE_ENTITY = "QuizScoreEntity"
    static let QUIZ_SCORE_TIME = "time"
    static let QUIZ_SCORE_COMPLETED = "completed"
    static let QUIZ_SCORE_CATEGORY = "category"
    
    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PERSISTENT_CONTAINER_NAME)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent store: \(error)")
            }
        })
        return container
    }()
    static private var managedObjectContext = persistentContainer.viewContext
    
    static func saveBeforeClosingApp(){
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not save object context. \(error)")
        }
    }
    
    //MARK: Quiz Score CRUD
    static func getAll_quizScores() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: QUIZ_SCORE_ENTITY)
        
        do {
            return try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            print("Failed fetching quiz scores. \(error)")
            return nil
        }
    }
    static func getMovingAverage_ofQuizScores(for category: QuizCategory, limit: Int = 100){
        //TODO: #warning("implement getMovingAverage_ofQuizScores")
    }
    static func save_quizScore(time: Double, category: QuizCategory, completed: Bool){
        let entity = NSEntityDescription.entity(forEntityName: QUIZ_SCORE_ENTITY, in: managedObjectContext)!
        let quizScore = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        quizScore.setValue(time, forKeyPath: QUIZ_SCORE_TIME)
        quizScore.setValue(completed, forKey: QUIZ_SCORE_COMPLETED)
        
        if let categoryFound = get_quizCategory(category) {
            quizScore.setValue(categoryFound, forKey: QUIZ_SCORE_CATEGORY)
        }else{
            save_quizCategory(category)
            guard let newCategory = get_quizCategory(category) else {
                print("error creating new category")
                return
            }
            quizScore.setValue(newCategory, forKey: QUIZ_SCORE_CATEGORY)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not save quiz score. \(error)")
        }
    }
    static func resetAll_quizScores(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: QUIZ_SCORE_ENTITY)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print("Failed deleting all quiz scores. \(error)")
        }
    }
    
    //MARK: Quiz Category CRUD
    static func get_quizCategory(_ enumValue: QuizCategory) -> NSManagedObject? {
        let name = enumValue.rawValue
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: QUIZ_CATEGORY_ENTITY)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "\(QUIZ_CATEGORY_NAME) == %@", name)
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            let quizCategory = result.first
            return quizCategory
        } catch {
            print("Failed fetching quiz category. \(error)")
            return nil
        }
    }
    static func save_quizCategory(_ enumValue: QuizCategory){
        let name = enumValue.rawValue
        let entity = NSEntityDescription.entity(forEntityName: QUIZ_CATEGORY_ENTITY, in: managedObjectContext)!
        let quizCategory = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        quizCategory.setValue(name, forKey: QUIZ_CATEGORY_NAME)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not save quiz score. \(error)")
        }
    }
}
