//
//  Story01.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 11/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Story01: SKScene {
    
    var background: SKSpriteNode!
    var sound: AVAudioPlayer?
    
    override init(size: CGSize) {
        super.init(size: size)
        setupStory01()
        setupSFX()
    }
    
    override func sceneDidLoad() {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (_) in
            self.sound?.play()
        }
    }
    
    func setupStory01() {
        let background: SKSpriteNode!
        
        if UIDevice.current.is_iPad(){
            background = SKSpriteNode(imageNamed: "story1_iphone")
            background.size = CGSize(width: background.size.width * 1.5, height: background.size.height * 1.5)
        }
        else {
            background = SKSpriteNode(imageNamed: "story1_iphone")
            background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        
        
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        addChild(background)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
            let nextStoryScene = Story02(size: self.size)
            self.scene?.view?.presentScene(nextStoryScene, transition: .fade(withDuration: 0.8))
        }
    }
    
    func setupSFX() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "\(sfxReference)bukamulut", ofType: "mp3")!)
        
        SFXPlayer.playSfx(soundEffectUrl: soundURL)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let nextStoryScene = Story02(size: size)
//        self.scene?.view?.presentScene(nextStoryScene, transition: .fade(withDuration: 0.8))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
