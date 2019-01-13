//
//  Player.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Prinny")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
        
    }
    
    func dodge(){

        let moveUp = SKAction.moveBy(x: 150, y: -150, duration: 0.2)
        let moveBack = SKAction.move(to: position, duration: 0.2)
        let dodgeAnimation = SKAction.sequence([moveUp,moveBack])
        
        self.run(dodgeAnimation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
