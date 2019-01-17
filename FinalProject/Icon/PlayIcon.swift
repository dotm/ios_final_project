//
//  Playbutton.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 14/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PlayIcon: SKSpriteNode {
    
    init(position: CGPoint, size: CGSize) {
        let texture = SKTexture(imageNamed: "play_btn")
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
}
