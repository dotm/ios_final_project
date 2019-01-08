//
//  QnA.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation

struct QnA {
    var question:String?
    var answer:[String] = []
    var correctIndex:Int?
    init(questions:String,answers:[String],correctIndex:Int) {
        self.question = questions
        self.answer = answers
        self.correctIndex = correctIndex
    }
    
}
