//
//  EnemyHP.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 07/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate let barHeight: CGFloat = 30
fileprivate let barWidth: CGFloat = 300

class EnemyHP: SKNode {
    
    private let layer = SKSpriteNode(color: UIColor(white: 0, alpha: 0.5), size: UIScreen.main.bounds.size)
    var arrHP : [SKShapeNode] = []
    
    var currentHP: Int = 0
    var duration: Double = 0.2
    
    private var onEmptyHP: (()->())!
    
    
    init(maxHP: Int, onEmptyHP: @escaping ()->() ) {
        
        self.onEmptyHP = onEmptyHP
        
        currentHP = 0
        
        super.init()
        
        let totalWidthHP: CGFloat = 300.0
        
        let width: CGFloat = (totalWidthHP / CGFloat(maxHP))
        let height: CGFloat = 30.0
        
        for i in 0..<maxHP {
            
            let health = SKShapeNode(rectOf: CGSize(width: width, height: height))
            
            health.fillColor = .red
            arrHP.append(health)
            
            health.position = CGPoint(x: CGFloat(i) * width, y: 30)
            
            addChild(health)
        }
        
    }
    
    func decreaseHP() {
        if currentHP < 4 {
            let decrease = SKAction.fadeAlpha(to: 0.0, duration: duration)
            
            arrHP[currentHP].run(decrease)
            
            currentHP = currentHP + 1
        }
        else if currentHP == 4
        {
            let decrease = SKAction.fadeAlpha(to: 0.0, duration: duration)
            
            arrHP[currentHP].run(decrease)
            
            onEmptyHP()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



