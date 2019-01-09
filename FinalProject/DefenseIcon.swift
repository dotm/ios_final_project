//
//  DefenseIcon.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 09/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class DefenseIcon: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "defense")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 150, height: 150))
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
