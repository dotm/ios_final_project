//
//  Attack.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class Damage: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "explosion_01")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 300, height: 300))
        self.position = position
        
    }
    
    func BeginDamage(completion:@escaping ()->Void) {
        let TextureAtlas = SKTextureAtlas(named: "Explosion")
        
        let frames = ["explosion_01","explosion_02","explosion_03","explosion_04","explosion_05","explosion_06","explosion_07","explosion_08","explosion_010","explosion_011","explosion_012","explosion_013","explosion_014","explosion_015"].map{TextureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.1)
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
