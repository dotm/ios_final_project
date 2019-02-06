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
    
    let textureOuter = SKSpriteNode(imageNamed: "frame_crystal")
//    let textureInner = SKSpriteNode(imageNamed: "frame_inner_noTitle")
    var quizBox:BasePopupQuiz?
    
    init(position: CGPoint, gameDelegate: PopupDelegate, category: QuizCategory) {
        super.init()
        self.position = position
        textureOuter.alpha = 0
        textureOuter.size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.6)
        
//        textureInner.size = textureOuter.size
//        textureInner.setScale(0.9)
//
//        self.addChild(textureInner)
        self.addChild(textureOuter)
        
        var alphabetArr: [String] = []
        
        for i in 1...26 {
            alphabetArr.append("alphabet_\(i)")
        }
        
        // create instance shapeSquare
        switch category {
        case .color:
            quizBox = ColorPopupQuiz(size: textureOuter.size)
        case .tracing:
            quizBox = TracingPopupQuiz(size: textureOuter.size, imageNamed: "A1" )
        default:
            quizBox = DummyPopupQuiz(size: textureOuter.size)
        }
        quizBox?.gameDelegate = gameDelegate
        // insert shape square to popupframe node
        self.addChild(quizBox!)
        // adding interactions for frame
        // setting z location node
        textureOuter.zPosition = 1
//        textureInner.zPosition = 2
        quizBox!.zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // calling shapeSquare action in this class
        quizBox?.touchesBegan(touches, with: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        quizBox?.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        quizBox?.touchesEnded(touches, with: event)
    }
}
