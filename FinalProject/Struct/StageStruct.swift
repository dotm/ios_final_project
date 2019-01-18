//
//  StageStruct.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 11/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation

struct Stage {
    
    var stageName: String
    var textureBackground: String
    var quizCategory: QuizCategory
    var mobSpawn: Enemy
    var quizTime: Double
    var nextStage: String
}

var stage1A = Stage(
    
    stageName: "stage1A",
    textureBackground: "background_snow",
    quizCategory: .color,
    mobSpawn: mobA,
    quizTime: 5,
    nextStage: "stage2A"
)


