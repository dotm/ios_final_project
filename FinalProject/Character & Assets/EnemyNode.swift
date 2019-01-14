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
    
    enum State{
        case walk, attack, defense, stagger
    }
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "idle_mob_01")
        
        let height = CGFloat(200)
        let rescale = height/texture.size().height
        let width = texture.size().width * rescale
        let size = CGSize(width: width, height: height)
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
    }
    
    func beginAnimation(state: State) {
        let PLAYER = "player"
        self.removeAction(forKey: PLAYER)
        let textureAtlas = SKTextureAtlas(named: "Mob")
        
        switch state {
        case .attack:
            let frames = ["attack_mob_01"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .walk:
            let frames = ["idle_mob_01"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
            
        case .defense:
            let frames = ["defense_mob_01"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .stagger:
            let frames = ["stagger_mob_01"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
        }
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
