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
        let texture = SKTexture(imageNamed: "k_1")
        
        let size = UIScreen.main.bounds.height * 0.6
        
        super.init(texture: texture, color: .clear, size: CGSize(width: size * 5, height: size))
        self.position = position
        self.anchorPoint = CGPoint(x: 0.05, y: 0.5)
        
        var frameArr: [String] = []
        
        for i in 1...50 {
            frameArr.append("k_\(i)")
        }
        self.alpha = 0
        self.frameArr = frameArr
    }
    
    func BeginAttack(completion:@escaping ()->Void) {
        let TextureAtlas = SKTextureAtlas(named: "Kamehameha")
        
        let frames = frameArr.map{TextureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.01)
        let attack = SKAction.repeat(animate, count: 1)
        self.alpha = 0.7
        self.run(attack) {
            self.alpha = 0
            completion()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
