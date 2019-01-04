//
//  PopupFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 04/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PopupFrame: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Frame")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
