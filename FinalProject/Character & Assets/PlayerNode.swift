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
        case walk, attack, defense, stagger, lose
    }
    
    var walkFrameArr: [String] = []
    var staggerFrameArr: [String] = []
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "idle_penguin0")
        
        let height = UIScreen.main.bounds.height * 0.5
        let rescale = height/texture.size().height
        let width = texture.size().width * rescale
        let size = CGSize(width: width, height: height)
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
        var walkFrameArr: [String] = []
        var staggerFrameArr: [String] = []
        
        for i in 0...23 {
            walkFrameArr.append("idle_penguin\(i)")
        }
        
        for i in 0...11 {
            staggerFrameArr.append("stagger_penguin_\(i)")
        }
        
        self.walkFrameArr = walkFrameArr
        self.staggerFrameArr = staggerFrameArr
        
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
            let frames = walkFrameArr.map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.08)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
            
        case .defense:
            let frames = ["penguin_defend"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.05)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .stagger:
            let frames = staggerFrameArr.map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .lose:
            let frames = ["penguin_sad"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
