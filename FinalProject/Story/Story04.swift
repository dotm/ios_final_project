//
//  Story04.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 11/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class Story04: SKScene {
    
    var background: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        setupStory04()
    }
    
    func setupStory04() {
        let background: SKSpriteNode!
        
        if UIDevice.current.is_iPad(){
            background = SKSpriteNode(imageNamed: "story4_iphone")
        }
        else {
            background = SKSpriteNode(imageNamed: "story4_iphone")
        }
        
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mainScene = MainScene(size: size)
        self.scene?.view?.presentScene(mainScene, transition: .fade(withDuration: 0.8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
