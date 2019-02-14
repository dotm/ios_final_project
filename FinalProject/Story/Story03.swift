//
//  Story03.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 11/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Story03: SKScene {
    
    var background: SKSpriteNode!
    var sound: AVAudioPlayer?
    
    override init(size: CGSize) {
        super.init(size: size)
        setupStory03()
        setupSFX()
    }
    
    override func sceneDidLoad() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (_) in
            self.sound?.play()
        }
    }
    
    func setupStory03() {
        let background: SKSpriteNode!
        
        if UIDevice.current.is_iPad(){
            background = SKSpriteNode(imageNamed: "story3_iphone")
        }
        else {
            background = SKSpriteNode(imageNamed: "story3_iphone")
        }
        
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        addChild(background)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
            let nextStoryScene = Story04(size: self.size)
            self.scene?.view?.presentScene(nextStoryScene, transition: .fade(withDuration: 0.8))
        }
    }
    
    func setupSFX() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "\(sfxReference)bingung", ofType: "mp3")!)
        
        SFXPlayer.playSfx(soundEffectUrl: soundURL)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let nextStoryScene = Story04(size: size)
//        self.scene?.view?.presentScene(nextStoryScene, transition: .fade(withDuration: 0.8))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
