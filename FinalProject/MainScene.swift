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
    var settingIcon: SettingIcon!
    var historyIcon: HistoryIcon!
    var helpIcon:HelpIcon!
    
   
    
    override init(size: CGSize) {
        super.init(size: size)
        setupMainBackground()
//        setupPlayIcon()
//        setupSettingIcon()
//        setupHistoryIcon()
//        setupHelpIcon()
        
    

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        BackgroundMusicPlayer.playMainMenuSong()
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.midX/2, y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.3)))
        addChild(playerNode)
        playerNode.beginAnimation(state: .standby)
    }
    
    private func setupMainBackground () {
        //background
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let textureImage:SKTexture
        if UIDevice.current.is_iPad(){
            textureImage = SKTexture(imageNamed: "background_home")
        }
        else {
            textureImage = SKTexture(imageNamed: "background_homescreen_iphoneX")
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
        let gameScene = GameScene(size: size, stage: stage1A)
        self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.8))
    }
    
//    private func setupPlayIcon()
//    {
//        //play icon button modifier
//        let height = UIScreen.main.bounds.size.height * 0.2
//        let position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - (0.3 * height))
//        let playIcon = PlayIcon(position: position, size: CGSize(width: height, height: height))
//        self.playIcon = playIcon
//        self.addChild(playIcon)
//
//    }
//    private func setupSettingIcon()
//    {
//        let heightSetting = playIcon.size.height * 0.5
//        let position = CGPoint(x: UIScreen.main.bounds.maxX - (heightSetting * 0.4), y: UIScreen.main.bounds.maxY - (heightSetting * 0.4) )
//        let settingIcon = SettingIcon(position: position, size: CGSize(width: heightSetting, height: heightSetting))
//        settingIcon.anchorPoint = CGPoint(x: 1 , y: 1 )
//        self.settingIcon = settingIcon
//        self.addChild(settingIcon)
//    }
//
//    private func setupHistoryIcon()
//    {
//        let heightHistory = playIcon.size.height * 0.5
//        let position = CGPoint(x: settingIcon.position.x , y: settingIcon.position.y - (heightHistory * 1.2))
//        let historyIcon = HistoryIcon(position: position, size: CGSize(width: heightHistory, height: heightHistory))
//        historyIcon.anchorPoint = CGPoint(x: 1 , y: 1 )
//        self.historyIcon = historyIcon
//        self.addChild(historyIcon)
//
//    }
//
//    private func setupHelpIcon()
//    {
//        let heightHelp = playIcon.size.height * 0.5
//        let position = CGPoint(x: historyIcon.position.x, y: historyIcon.position.y - (heightHelp * 1.2))
//        let helpIcon = HelpIcon(position: position, size: CGSize(width: heightHelp, height: heightHelp))
//        helpIcon.anchorPoint = CGPoint(x: 1, y: 1)
//        self.helpIcon = helpIcon
//        self.addChild(helpIcon)
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        playIcon?.touchesBegan(touches, with: event)
//        for touch:AnyObject in touches
//        {
//            let location = touch.location(in: self)
//            if playIcon!.contains(location) {
//                print("play icon touches")
//                let gameScene = GameScene(size: size, stage: stage1A)
//                self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.8))
//
//            }
//            else if settingIcon!.contains(location)
//            {
//                print("settingIcon touches")
//                let settingPopup = SettingPopup(position: CGPoint(x: UIScreen.main.bounds.midX , y: UIScreen.main.bounds.midY))
//                settingPopup.touchesBegan(touches, with: event)
//                addChild(settingPopup)
//
//            }
//            else if historyIcon!.contains(location)
//            {
//                print("history icon are touches")
//                //adding black layer
////                layer.anchorPoint = CGPoint(x: 0, y: 0)
////                addChild(layer)
////                layer.name = "layer"
//                let chooseMode = ChooseMode(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
//                chooseMode.touchesBegan(touches, with: event)
//                addChild(chooseMode)
//
//            }
////            else if helpIcon!.contains(location)
////            {
////                print("help icon are touches")
////            }
////            else{
////                print("touching others")
////            }
//        }
//    }
}

