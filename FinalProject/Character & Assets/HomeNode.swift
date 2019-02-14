//
//  homeNode.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 13/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class HomeNode: SKSpriteNode {
    
    init(position: CGPoint) {
        
        let width: CGFloat = UIScreen.main.bounds.width * 0.3
        let height: CGFloat = UIScreen.main.bounds.height * 0.3
        
        super.init(texture: nil, color:.clear, size: CGSize(width: width, height: height))
        self.position = position
        
        let enemyHomeNode = EnemyHomeNode(position: CGPoint(x: self.frame.width/3, y: self.frame.minY))
        let playerHomeNode = PlayerNode(position: CGPoint(x: -self.frame.width/3, y: self.frame.minY))
        
        enemyHomeNode.anchorPoint = CGPoint(x: 0.5, y: 1)
        playerHomeNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(enemyHomeNode)
        addChild(playerHomeNode)
        
        enemyHomeNode.enemyRunSetup()
        playerHomeNode.playerRunSetup()
    }
    
    func moving() {
        let moveright = SKAction.moveTo(x: UIScreen.main.bounds.maxX + 200, duration: 3)
        let moveleft = SKAction.moveTo(x: UIScreen.main.bounds.minX - 200, duration: 3)
        let flip1 = SKAction.scaleX(to: -1, duration: 0.1)
        let flip2 = SKAction.scaleX(to: 1, duration: 0.1)
        
        let sequence = SKAction.sequence([moveright,flip1,moveleft,flip2])
        let forever = SKAction.repeatForever(sequence)
        
        self.run(forever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
