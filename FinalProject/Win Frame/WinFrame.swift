//
//  WinFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 16/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class WinFrame: SKScene {
    
    var background: SKSpriteNode!
    var pose: SKSpriteNode!
    
    var currentStage: Stage!
    
    var sound: AVAudioPlayer?
    
    init(size: CGSize, currentStage: Stage) {
        
        self.currentStage = currentStage
        
        super.init(size: size)
    }
    
    override func sceneDidLoad() {
        setupSFX()
        setupBackgroundImage()
        setupCelebrationImage()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
                let nextScene: SKScene
                
                if let nextStage = currentStage.nextStage.first {
                    nextScene = GameScene(size: (scene?.size)!, stage: nextStage)
                }
                else
                {
                    nextScene = MainScene(size: (scene!.size))
                }
                
                self.scene?.view?.presentScene(nextScene, transition: .fade(withDuration: 0.8))
    }
    
    func setupCelebrationImage() {
        let celebration = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))

        celebration.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        if UIDevice.current.is_iPad(){
            celebration.size = CGSize(width: celebration.size.width * 1.5, height: celebration.size.height * 1.5)
        }
        else {
            celebration.size = CGSize(width: celebration.size.width * 1.5, height: celebration.size.height * 1.5)
        }

        addChild(celebration)
        
        if energyAmount == 0 {
            celebration.normalWinSetup()
            energyAmount += 1
        }
        else if  energyAmount == 1{
            celebration.secondWinSetup()
            energyAmount += 1
        }
        else if energyAmount == 2{
            celebration.finalWinSetup()
            energyAmount = 0
        }
    }
    
    func setupBackgroundImage() {
        let background = SKSpriteNode(imageNamed: "Frame")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        addChild(background)
    }
    
    func setupSFX() {
        let soundURL: URL
        
        if energyAmount < 2 {
            soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "\(sfxReference)woohoo", ofType: "mp3")!)
        }
        else {
            soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "\(sfxReference)finalWin", ofType: "mp3")!)
        }
        
        SFXPlayer.playSfx(soundEffectUrl: soundURL, fadeOutBgmVolume: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
