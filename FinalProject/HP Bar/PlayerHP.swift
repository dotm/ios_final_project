//
//  PlayerHP.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 07/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerHP: SKSpriteNode {
    
    var arrHP : [SKSpriteNode] = []
    
    var currentHP: Int = 0
    var duration: Double = 0.2

    private var onEmptyHP: (()->())!
    
    init(maxHP: Int, onEmptyHP: @escaping ()->() ) {
        
        print(111, UIScreen.main.bounds.height)
        
        self.onEmptyHP = onEmptyHP
        
        currentHP = maxHP
        
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
        
//        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        for i in 0..<maxHP {
            
            let health = SKSpriteNode(imageNamed: "health_player")
            
            arrHP.append(health)
            
            health.size = CGSize(width: width, height: height)
            health.anchorPoint = CGPoint(x: 0, y: 0)
            health.position = CGPoint(x: CGFloat(i) * width, y: yCoor)
            
            addChild(health)
        }
        
    }
    
    func decreaseHP() {
        
        if currentHP > 1 {
            let decrease = SKAction.fadeAlpha(to: 0.0, duration: duration)
            
            arrHP[currentHP -  1].run(decrease)
            
            currentHP = currentHP - 1
        }
        else if currentHP == 1
        {
            let decrease = SKAction.fadeAlpha(to: 0.0, duration: duration)
            
            arrHP[currentHP -  1].run(decrease)
            
            onEmptyHP()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
