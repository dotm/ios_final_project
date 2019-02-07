//
//  MainScene.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 14/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics

fileprivate let layer = SKSpriteNode(color: UIColor(white: 0, alpha: 0.8), size: UIScreen.main.bounds.size)

class MainScene: SKScene {
    var backgroundImg:SKSpriteNode!
    var playIcon:PlayIcon!
    
    override init(size: CGSize) {
        super.init(size: size)
        setupMainBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        BackgroundMusicPlayer.playMainMenuSong()
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.3)))
        addChild(playerNode)
        playerNode.jugglingSetup()
    }
    
    private func setupMainBackground () {
        //background
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let textureImage:SKTexture
        if UIDevice.current.is_iPad(){
            textureImage = SKTexture(imageNamed: "homescreen_ipad_1")
        }
        else {
            textureImage = SKTexture(imageNamed: "homescreen_iphone_1")
        }
        let size = CGSize(width: screenWidth, height: screenHeight)
        let backgroundImg = SKSpriteNode(texture: textureImage, color: .clear, size: size)
        self.backgroundImg = backgroundImg
        self.backgroundImg.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        
        guard let snowParticle = SKEmitterNode(fileNamed: "SnowParticle") else { return }
        snowParticle.position = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
        snowParticle.zPosition = -1
        self.addChild(snowParticle)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tutorialScene = TutorialScene(size: size)
        self.scene?.view?.presentScene(tutorialScene, transition: .fade(withDuration: 0.8))
    }
}

