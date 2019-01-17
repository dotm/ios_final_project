//
//  HelpIcon.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 14/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class HelpIcon: SKSpriteNode {
    
    init(position: CGPoint,size: CGSize) {
        let texture = SKTexture(imageNamed: "icon_help")
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
