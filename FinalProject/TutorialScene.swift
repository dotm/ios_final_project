//
//  TutorialScene.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 06/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    
    override init(size: CGSize) {
        
        super.init(size: size)
    }
    
    override func sceneDidLoad() {
        setupBackground()
        setupTutorialNode()
        
//        if tutorialSkip == true {
//            setupSkipButton()
//        }
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "Frame")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        addChild(background)
    }
    
    func setupTutorialNode() {
        
        let tutorialNode = TutorialNode(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
        
        if UIDevice.current.is_iPad(){
            tutorialNode.size = CGSize(width: tutorialNode.size.width * 2, height: tutorialNode.size.height * 2)
        }
        else {
            tutorialNode.size = CGSize(width: tutorialNode.size.width * 2, height: tutorialNode.size.height * 2)
        }
        
        addChild(tutorialNode)
        tutorialNode.startTutorialAnimation()
    }
    
//    func setupSkipButton() {
//        let skipButton = SkipButton(position: CGPoint(x: UIScreen.main.bounds.maxX * 0.7, y: UIScreen.main.bounds.maxY * 0.7))
//
//        addChild(skipButton)
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if tutorialSkip == true {
//            let gameScene = GameScene(size: size, stage: stage1A)
//            self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.8))
//        }
//        else {
//
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
