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
        
        let size: CGFloat
        
        if UIScreen.main.bounds.height > 500 {
            size = UIScreen.main.bounds.height * 0.2
        }
        else {
            size = UIScreen.main.bounds.height * 0.3
        }
        
        super.init(texture: texture, color: .clear, size: CGSize(width: size, height: size))
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
