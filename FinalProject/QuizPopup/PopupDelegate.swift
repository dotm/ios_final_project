//
//  PopupDelegate.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 07/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//
import SpriteKit

protocol PopupDelegate {
    func handleAnswerCorrect()
    func handleAnswerWrong()
}

class BasePopupQuiz:SKNode{
    var gameDelegate:PopupDelegate?
}
