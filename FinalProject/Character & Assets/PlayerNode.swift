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
        case walk, attack, defense, stagger
    }
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "penguin_idle_1")
        
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
        let textureAtlas = SKTextureAtlas(named: "penguin")
        
        switch state {
        case .attack:
            let frames = ["penguin_attack"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .walk:
            let frames = ["penguin_idle_1","penguin_idle_2"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.3)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
            
        case .defense:
            let frames = ["penguin_defend"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .stagger:
            let frames = ["penguin_stagger"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
