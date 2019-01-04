//
//  Player.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Prinny")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
        //        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        //        self.physicsBody?.isDynamic = true
        //        self.physicsBody?.affectedByGravity = true
        //        self.physicsBody?.mass = 0.5
        //        self.physicsBody?.usesPreciseCollisionDetection = true
        //
        //        self.physicsBody?.categoryBitMask = PlayerCategory
        //        self.physicsBody?.collisionBitMask = FloorCategory
        //        self.physicsBody?.contactTestBitMask = FloorCategory
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
