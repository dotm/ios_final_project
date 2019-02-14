//
//  enemyHomeNode.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 13/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyHomeNode: SKSpriteNode {
    
    var enemyRunArr: [String] = []
    
    init(position: CGPoint) {
        
        var enemyRunArr: [String] = []
        
        for i in 1...3 {
            enemyRunArr.append("run\(i)")
        }
        
        let texture = SKTexture(imageNamed: "run1")
        
        let scale: CGFloat
        
        if UIDevice.current.is_iPad(){
            scale = 2.0
        }
        else {
            scale = 3.0
        }
        
        let height = texture.size().height / scale
        let width = texture.size().width / scale
        let size = CGSize(width: width, height: height)
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        self.enemyRunArr = enemyRunArr
    }
    
    func enemyRunSetup() {
        let textureAtlas = SKTextureAtlas(named: "Mob A")
        
        let frames = enemyRunArr.map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.1)
        let run = SKAction.repeatForever(animate)
        
        self.run(run)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
