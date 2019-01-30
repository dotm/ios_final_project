//
//  Player.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 03/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyNode: SKSpriteNode {
    
    enum State{
        case walk, attack, defense, stagger, lose
    }
    
    var enemy: Enemy!
    
    init(position: CGPoint, enemy: Enemy) {
        
        self.enemy = enemy
        
        let texture = SKTexture(imageNamed: enemy.textureStandbyNameA)
        
        let height = UIScreen.main.bounds.height * 0.2
        let rescale = height/texture.size().height
        let width = texture.size().width * rescale
        let size = CGSize(width: width, height: height)
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
    }
    
    func beginAnimation(state: State) {
        let ENEMY = "enemy"
        self.removeAction(forKey: ENEMY)
        let textureAtlas = SKTextureAtlas(named: enemy.enemyName)
        
        switch state {
        case .attack:
            let frames = [enemy.textureAttackNameA, enemy.textureAttackNameB,  enemy.textureAttackNameC,  enemy.textureAttackNameD].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: ENEMY)
            
        case .walk:
            let frames = [enemy.textureStandbyNameA,enemy.textureStandbyNameB].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 0.3)
            let forever = SKAction.repeatForever(animate)
            self.run(forever, withKey: ENEMY)
            
        case .defense:
            let frames = [enemy.textureDefenseName].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: ENEMY)
            
        case .stagger:
            let frames = [enemy.textureStaggerName].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: ENEMY)
            
        case .lose:
            let frames = ["lose_mob"].map{textureAtlas.textureNamed($0)}
            let animate = SKAction.animate(with: frames, timePerFrame: 1)
            let forever = SKAction.repeat(animate, count: 1)
            self.run(forever, withKey: ENEMY)
        }
    }
    
    func dies(){
        let textureAtlas = SKTextureAtlas(named: enemy.enemyName)
        
        let frames = [enemy.textureStaggerName].map{textureAtlas.textureNamed($0)}
        let animate = SKAction.animate(with: frames, timePerFrame: 1)
        let stagger = SKAction.repeat(animate, count: 1)
        
        let decrease = SKAction.fadeAlpha(to: 0.0, duration: 0.2)
        
        let sequence = SKAction.sequence([stagger,decrease])
        
        self.run(sequence)
    }
    
    func defense() {
        let textureAtlas = SKTextureAtlas(named: enemy.enemyName)
        
        let framesDefense = [enemy.textureDefenseName].map{textureAtlas.textureNamed($0)}
        let animateDefense = SKAction.animate(with: framesDefense, timePerFrame: 1)
        let defense = SKAction.repeat(animateDefense, count: 1)
        
        let framesWalk = [enemy.textureStandbyNameA,enemy.textureStandbyNameB].map{textureAtlas.textureNamed($0)}
        let animateWalk = SKAction.animate(with: framesWalk, timePerFrame: 0.3)
        let walk = SKAction.repeatForever(animateWalk)
        
        let sequence = SKAction.sequence([defense,walk])
        
        self.run(sequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
