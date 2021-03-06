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
import LocalAuthentication

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
        BackgroundMusicPlayer.setVolume(1.0)
        BackgroundMusicPlayer.playMainMenuSong()
//        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.3)))
//        addChild(playerNode)
//        playerNode.jugglingSetup()
        
        let standbyNode: HomeNode
        
        if UIDevice.current.is_iPad(){
            standbyNode = HomeNode(position: CGPoint(x: UIScreen.main.bounds.minX - 200, y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.2)))
        }
        else {
            standbyNode = HomeNode(position: CGPoint(x: UIScreen.main.bounds.minX - 200, y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.23)))
        }

        addChild(standbyNode)
        standbyNode.moving()
//        standbyNode.xScale = standbyNode.xScale * -1
    }
    
    private func setupMainBackground () {
        //background
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let textureImage:SKTexture
        if UIDevice.current.is_iPad(){
            textureImage = SKTexture(imageNamed: "homescreen_bubu_ipad")
        }
        else {
            textureImage = SKTexture(imageNamed: "homescreen_bubu_iphone")
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
//        if energyAmount == 2 {
//            authenticateUser()
//        }
//        else {
//            let tutorialScene = TutorialScene(size: size)
//            self.scene?.view?.presentScene(tutorialScene, transition: .fade(withDuration: 0.8))
//        }
        
        let tutorialScene = TutorialScene(size: size)
        self.scene?.view?.presentScene(tutorialScene, transition: .fade(withDuration: 0.8))
    }
}

fileprivate func authenticateUser() {
    let context = LAContext()
    
    context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Ask mom to open it for you") {(success, error) in
        
        guard success else {
            
            return
        }
        
        energyAmount = 0
    }
}

