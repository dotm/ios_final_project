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
    
    var frameArr: [String] = []
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "impact_1")
        
        let size = UIScreen.main.bounds.height * 0.6
        
        super.init(texture: texture, color: .clear, size: CGSize(width: size, height: size))
        self.position = position
        
        var frameArr: [String] = []
        
        for i in 1...8 {
            frameArr.append("impact_\(i)")
        }
        
        self.frameArr = frameArr
    }
    
    func BeginDamage(completion:@escaping ()->Void) {
        let TextureAtlas = SKTextureAtlas(named: "Impact")
        
        let frames = frameArr.map{TextureAtlas.textureNamed($0)}
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
