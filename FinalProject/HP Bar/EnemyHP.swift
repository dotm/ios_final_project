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

class EnemyHP: SKSpriteNode {
    
    var currentHP: Int
    var arrHP : [SKSpriteNode] = []
    var maxHP: Int
    
    var duration: Double = 0.2
    
    private var onEmptyHP: (()->())!
    
    init(maxHP: Int, onEmptyHP: @escaping ()->() ) {
        
        self.onEmptyHP = onEmptyHP
        self.maxHP = maxHP
        
        currentHP = 0
        
        let totalWidthHP: CGFloat = UIScreen.main.bounds.width * 0.4
        let width: CGFloat = (totalWidthHP / CGFloat(maxHP))
        
        let height: CGFloat
        let yCoor: CGFloat
        
        if UIScreen.main.bounds.height < 500.0 {
            height = UIScreen.main.bounds.height * 0.1
            yCoor = 30
        }
        else
        {
            height = UIScreen.main.bounds.height * 0.05
            yCoor = 30
        }
        
        super.init(texture: nil, color: .clear, size: CGSize(width: totalWidthHP, height: height))
        
        for i in 0..<maxHP {
            
            let health = SKSpriteNode(imageNamed: "health_boss")
            
            arrHP.append(health)
            
            health.size = CGSize(width: width, height: height)
            health.anchorPoint = CGPoint(x: 0, y: 0)
            health.position = CGPoint(x: CGFloat(i) * width, y: yCoor)
            
            addChild(health)
        }
        
    }
    
    func decreaseHP() {
        
        if currentHP < maxHP {
            let decrease = SKAction.fadeAlpha(to: 0.0, duration: duration)
            arrHP[currentHP].run(decrease)
            
            currentHP = currentHP + 1
        }
        else
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



