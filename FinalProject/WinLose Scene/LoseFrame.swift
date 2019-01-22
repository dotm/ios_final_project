//
//  WinFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 16/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit

class LoseFrame: SKScene {
    
    private var returnButton: SKSpriteNode!
    private var replayButton: SKSpriteNode!
    
    var background: SKSpriteNode!
    var pose: SKSpriteNode!
    
    override init(size: CGSize) {
        let background = SKSpriteNode(imageNamed: "frame_lose")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        let loseEnemy = SKSpriteNode(imageNamed: "penguin_mainpage")
        loseEnemy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loseEnemy.size = CGSize(width: loseEnemy.size.width, height: loseEnemy.size.height)
        loseEnemy.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.pose = loseEnemy
        
        super.init(size: size)
    }
    
    override func sceneDidLoad() {
        addChild(background)
        addChild(pose)
        
        setupReplayButton()
        setupReturnButton()
    }
    
    func setupReturnButton(){
        let returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_exit"), color: .clear, size: CGSize(width: (self.frame.width / 8), height: (self.frame.width / 8)))
        
        returnButton.position = CGPoint(x: UIScreen.main.bounds.width / 3, y: UIScreen.main.bounds.height * 0.15)
        
        addChild(returnButton)
        
        self.returnButton = returnButton
    }
    
    func setupReplayButton() {
        let replayButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_ok"), color: .clear, size: CGSize(width: (self.frame.width / 8), height: (self.frame.width / 8)))
        
        replayButton.position = CGPoint(x: UIScreen.main.bounds.width * 2 / 3, y: UIScreen.main.bounds.height * 0.15)
        
        addChild(replayButton)
        
        self.replayButton = replayButton
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if returnButton.contains(location) {
                let mainScene = MainScene(size: (scene?.size)!)
                self.scene?.view?.presentScene(mainScene, transition: .fade(withDuration: 0.8))
            }
            else if replayButton.contains(location) {
                let gameScene = GameScene(size: (scene?.size)!, stage: stage1A)
                self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.8))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
