//
//  PopupFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 04/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PopupFrame: SKNode {
    
    let texture = SKSpriteNode(imageNamed: "Frame")
    var quizBox:ColorPopupQuiz?
    
    init(position: CGPoint, gameDelegate: PopupDelegate, category: QuizCategory) {
        super.init()
        self.position = position
        texture.size = CGSize(width: 600, height: 250)
        self.addChild(texture)
        // create instance shapeSquare
        switch category {
        case .color:
            quizBox = ColorPopupQuiz(size: texture.size)
        default:
            quizBox = ColorPopupQuiz(size: texture.size)
        }
        quizBox?.gameDelegate = gameDelegate
        // insert shape square to popupframe node
        self.addChild(quizBox!)
        // adding interactions for frame
        // setting z location node
        texture.zPosition = 1
        quizBox!.zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // calling shapeSquare action in this class
        print("touched frame")
        quizBox?.touchesBegan(touches, with: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        quizBox?.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        quizBox?.touchesEnded(touches, with: event)
    }
}
