//
//  SkipButton.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 07/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class SkipButton: SKSpriteNode {
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "play_btn")
        
        let size = CGSize(width: texture.size().width, height: texture.size().height)
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
