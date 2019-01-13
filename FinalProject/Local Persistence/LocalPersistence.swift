//
//  LocalPersistence.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 13/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import CoreData

enum QuizCategory: String {
    case color
    case shape
}

enum LocalPersistence {
    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent store: \(error)")
            }
        })
        return container
    }()
    
    func save_quizScore(time: Double, category: QuizCategory, completed: Bool){
        
    }
    
    func seed_quizCategories(){
        
    }
    func getAll_quizCategories(){
        
    }
    
    func getMovingAverage_ofQuizScore(for category: QuizCategory, limit: Int = 100){
        
    }
    
    func resetAll_quizScores(){
        
    }
}
