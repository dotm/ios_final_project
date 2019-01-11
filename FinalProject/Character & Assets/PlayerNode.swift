//
//  Player.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    enum State{
        case walk, jump
    }
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "penguin_walk01")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
    }
    
    func beginAnimation(state: State) {
        let PLAYER = "player"
        self.removeAction(forKey: PLAYER)
        let textureAtlas = SKTextureAtlas(named: "penguin")
        
        switch state {
        case .jump:
            let frames = ["penguin_jump01","penguin_jump02","penguin_jump03"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.3)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .walk:
            let frames = ["penguin_walk01","penguin_walk02","penguin_walk03","penguin_walk04"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
        }
    }
    
    func dodge(){
        
        let moveUp = SKAction.moveBy(x: -150, y: -150, duration: 0.2)
        let moveBack = SKAction.move(to: position, duration: 0.2)
        let dodgeAnimation = SKAction.sequence([moveUp,moveBack])
        
        self.run(dodgeAnimation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
