//
//  Player.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    enum State{
        case walk, attack, defense, stagger, lose, standby
    }
    
    var walkFrameArr: [String] = []
    var staggerFrameArr: [String] = []
    var standbyFrameArr: [String] = []
    var normalWinArr: [String] = []
    var finalWinArr: [String] = []
    var jugglingArr: [String] = []
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "idle_penguin0")
        
        let height = UIScreen.main.bounds.height * 0.5
        let rescale = height/texture.size().height
        let width = texture.size().width * rescale
        let size = CGSize(width: width, height: height)
        
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
        var walkFrameArr: [String] = []
        var staggerFrameArr: [String] = []
        var standbyFrameArr: [String] = []
        var normalWinArr: [String] = []
        var finalWinArr: [String] = []
        var jugglingArr: [String] = []
        
        for i in 0...23 {
            walkFrameArr.append("idle_penguin\(i)")
        }
        
        for i in 0...11 {
            staggerFrameArr.append("stagger_penguin_\(i)")
        }
        
        for i in 0...59 {
            standbyFrameArr.append("front_half_eyes 2_\(i)")
        }
        
        for i in 0...29 {
            normalWinArr.append("normalWinFrames_\(i)")
        }
        
        for i in 1...12 {
            jugglingArr.append("juggling_\(i)")
        }
        
        for i in 0...59 {
            finalWinArr.append("finalCelebration_\(i)")
        }
        
        self.walkFrameArr = walkFrameArr
        self.staggerFrameArr = staggerFrameArr
        self.standbyFrameArr = standbyFrameArr
        self.normalWinArr = normalWinArr
        self.finalWinArr = finalWinArr
        self.jugglingArr = jugglingArr
        
    }
    
    func beginAnimation(state: State) {
        let PLAYER = "player"
        self.removeAction(forKey: PLAYER)
        let textureAtlas = SKTextureAtlas(named: "penguin")
        
        switch state {
        case .attack:
            let frames = ["penguin_attack"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .walk:
            let frames = walkFrameArr.map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.08)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
            
        case .defense:
            let frames = ["penguin_defend"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.05)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .stagger:
            let frames = staggerFrameArr.map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .lose:
            let frames = ["penguin_sad"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: PLAYER)
            
        case .standby:
            let frames = standbyFrameArr.map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.02)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: PLAYER)
        }
    }
    
    func normalWinSetup() {
        let textureAtlas = SKTextureAtlas(named: "Normal Win Frame")
        
        let frames = normalWinArr.map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
        let normalWin = SKAction.repeat(animate, count: 1)
        
        self.run(normalWin)
    }
    
    func finalWinSetup() {
        let textureAtlas = SKTextureAtlas(named: "Final Win Frame")
        
        let frames = finalWinArr.map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
        let finalWin = SKAction.repeat(animate, count: 1)
        
        self.run(finalWin)
    }
    
    func jugglingSetup() {
        let textureAtlas = SKTextureAtlas(named: "Juggling")
        
        let frames = jugglingArr.map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 0.08)
        let juggling = SKAction.repeatForever(animate)
        
        self.run(juggling)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
