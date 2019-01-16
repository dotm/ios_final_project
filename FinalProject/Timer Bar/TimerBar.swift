//
//  TimerBar.swift
//  testHPBar
//
//  Created by Yuvens Putra Barata on 09/01/19.
//  Copyright © 2019 Yuvens Putra Barata. All rights reserved.
//

import Foundation
import SpriteKit

class TimerBar: SKSpriteNode {
    
    private var timerFront: SKSpriteNode?
    
    private var complete: (()->())!
    private var duration: Double
    
    init(position: CGPoint, duration: Double, complete: @escaping ()->()) {
        let size: CGSize
        
        if UIScreen.main.bounds.height < 500 {
            size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.1)
        }
        else {
            size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.05)
        }
        
        let anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.complete = complete
        self.duration = duration
        
        super.init(texture: nil, color: .clear, size: size)
        self.position = position
        self.anchorPoint = anchorPoint
        
        let timerBase = SKSpriteNode(imageNamed: "time_baseBar")
        let timerFront = SKSpriteNode(imageNamed: "time_frontBar")
        
        self.timerFront = timerFront
        
        timerBase.size = size
//        timerBase.position = position
        timerBase.anchorPoint = anchorPoint
        
        timerFront.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        timerFront.size = size
        timerFront.position.x = -(self.size.width/2)
        
        addChild(timerBase)
        addChild(timerFront)
        
    }
    
    func changeSize() {
        let change = SKAction.resize(toWidth: 0, duration: duration)
        
        timerFront!.run(change) {
            self.complete()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
