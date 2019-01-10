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
    
    private var complete: (()->())!
    private var duration: Double
    
    init(position: CGPoint, duration: Double, complete: @escaping ()->()) {
        
        self.complete = complete
        self.duration = duration
        
        super.init(texture: nil, color: .green, size: CGSize(width: 400, height: 25))
        self.position = position
        self.anchorPoint = CGPoint(x: 0.0, y: 0.5)
    }
    
    func changeSize() {
        let change = SKAction.resize(toWidth: 0, duration: duration)
        let changeColorYellow = SKAction.colorize(with: .yellow, colorBlendFactor: 0, duration: duration/2)
        let changeColorRed = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: duration/2)
        let changeColor = SKAction.sequence([changeColorYellow,changeColorRed])
        
        let timerAnimation = SKAction.group([change,changeColor])
        
        self.run(timerAnimation) {
            self.complete()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
