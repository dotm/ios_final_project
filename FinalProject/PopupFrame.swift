//
//  PopupFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 04/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PopupFrame: SKNode {
    
    init(position: CGPoint) {
        super.init()
        self.position = position
        let texture = SKSpriteNode(imageNamed: "Frame")
        self.addChild(texture)
        let shapeSquare = PopupQuiz(size: texture.size)
        self.addChild(shapeSquare)
        
        texture.zPosition = 2
        shapeSquare.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
