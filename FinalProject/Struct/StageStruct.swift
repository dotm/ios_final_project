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
    var ipadBattleBackground: String
    var iphoneBattleBackground: String
    var quizCategory: QuizCategory
    var mobSpawn: Enemy
    var quizTime: Double
    var nextStage: [Stage]
}

var stage1A = Stage(
    
    stageName: "stage1A",
    ipadBattleBackground: "background_ipad_1",
    iphoneBattleBackground: "background_iphone_1",
    quizCategory: .tracing,
    mobSpawn: mobA,
    quizTime: 5,
    nextStage: [stage2A]
)

var stage2A = Stage(
    
    stageName: "stage2A",
    ipadBattleBackground: "background_ipad_1",
    iphoneBattleBackground: "background_iphone_1",
    quizCategory: .tracing,
    mobSpawn: mobA,
    quizTime: 5,
    nextStage: [stage3A]
)

var stage3A = Stage(
    
    stageName: "stage3A",
    ipadBattleBackground: "background_ipad_1",
    iphoneBattleBackground: "background_iphone_1",
    quizCategory: .tracing,
    mobSpawn: mobA,
    quizTime: 5,
    nextStage: []
)


