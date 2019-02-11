//
//  TutorialNode.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 07/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialNode: SKSpriteNode {
    
    var tutorialArr: [String] = []
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "tutorial_001 copy 0")
        let size = CGSize(width: texture.size().width, height: texture.size().height)
        super.init(texture: texture, color:.clear, size: size)
        
        var tutorialArr: [String] = []
        
        for i in 0...60 {
            tutorialArr.append("tutorial_001 copy \(i)")
        }
        
        self.tutorialArr = tutorialArr
        self.position = position
    }
    
    func startTutorialAnimation() {
        let textureAtlas = SKTextureAtlas(named: "Tutorial")
        
        let frames = tutorialArr.map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.08)
        let tutorial = SKAction.repeat(animate, count: 1)
        
        self.run(tutorial, completion: skipTutorial)
    }
    
    func skipTutorial() {
//        tutorialSkip = true
        let gameScene = GameScene(size: self.scene!.size, stage: stage1A)
        self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
