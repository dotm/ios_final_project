//
//  Attack.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class Attack: SKSpriteNode {
    
    var frameArr: [String] = []
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "ice_spike_01")
        
        let size = UIScreen.main.bounds.height * 0.8
        
        super.init(texture: texture, color: .clear, size: CGSize(width: size, height: size))
        self.position = position
        
        var frameArr: [String] = []
        
        for i in 1...50 {
            frameArr.append("ice_spike_\(i)")
        }
        
        self.frameArr = frameArr
    }
    
    func BeginAttack(completion:@escaping ()->Void) {
        let TextureAtlas = SKTextureAtlas(named: "Ice Spike")
        
        let frames = frameArr.map{TextureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.02)
        let forever = SKAction.repeat(animate, count: 1)
        self.run(forever) {
            completion()
        }
//        self.run(forever, withKey: "player")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
