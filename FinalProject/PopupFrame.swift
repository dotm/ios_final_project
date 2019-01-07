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
    
    let texture = SKSpriteNode(imageNamed: "Frame")
    var shapeSquare:PopupQuiz?
    
    init(position: CGPoint) {
        super.init()
        self.position = position
        self.addChild(texture)
        // create instance shapeSquare
        shapeSquare = PopupQuiz.init(size: texture.size)
        // insert shape square to popupframe node
        self.addChild(shapeSquare!)
        // adding interactions for frame
        // setting z location node
        texture.zPosition = 2
        shapeSquare!.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // calling shapeSquare action in this class
        print("touched frame")
        shapeSquare?.touchesBegan(touches, with: event)
    }
}
