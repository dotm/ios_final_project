//
//  GameScene.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 02/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player(position: CGPoint(x: 150, y: 120))
    let enemy = Enemy(position: CGPoint(x: 600, y: 150))
    let attack = Attack(position: CGPoint(x: 600, y: 150))
    let popupframe = PopupFrame(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
    
    override func sceneDidLoad() {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        addChild(background)
        addChild(player)
        addChild(enemy)
        
        player.beginAnimation(state: .walk)
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isUserInteractionEnabled = false
//        addChild(attack)
//        attack.BeginAttack {
//            self.attack.removeFromParent()
//            self.isUserInteractionEnabled = true
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let layer = SKSpriteNode(color: UIColor(white: 0, alpha: 0.5), size: UIScreen.main.bounds.size)
        layer.position = CGPoint(x:  UIScreen.main.bounds.midX, y:  UIScreen.main.bounds.midY)
        
        addChild(layer)
        addChild(popupframe)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
