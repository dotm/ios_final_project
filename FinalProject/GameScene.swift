//
//  GameScene.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 02/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit

fileprivate let layer = SKSpriteNode(color: UIColor(white: 0, alpha: 0.5), size: UIScreen.main.bounds.size)

class GameScene: SKScene {
    
    let player = Player(position: CGPoint(x: 150, y: 120))
    let enemy = Enemy(position: CGPoint(x: 600, y: 150))
    let attack = Attack(position: CGPoint(x: 600, y: 150))
    
    var playerTurn: Bool = true
    
    private var popupframe: PopupFrame!
    
    private var popupflag: String = "false"
    
    private var playerHP: PlayerHP!
    private var enemyHP: EnemyHP!
    
    override init(size: CGSize) {
        super.init(size: size)
        self.popupframe = PopupFrame(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY), gameDelegate: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        let playerHP = PlayerHP(maxHP: 5)
        let enemyHP = EnemyHP(maxHP: 5) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                self.addChild(layer)
//                self.addChild(self.popupframe)
            })
        }
        
        self.playerHP = playerHP
        self.enemyHP = enemyHP
        
        playerHP.position = CGPoint(x: UIScreen.main.bounds.minX + 60, y: UIScreen.main.bounds.maxY - 70)
        enemyHP.position = CGPoint(x: UIScreen.main.bounds.maxX - 360, y: UIScreen.main.bounds.maxY - 70)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        addChild(background)
        addChild(player)
        addChild(enemy)
        
        addChild(playerHP)
        addChild(enemyHP)
        
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
        layer.position = CGPoint(x:  UIScreen.main.bounds.midX, y:  UIScreen.main.bounds.midY)
        
        if popupflag == "false" {
 
            addChild(layer)
            addChild(popupframe)
            
            popupflag = "true"
        } else {
            // calling touch began in popupframe method
            popupframe.touchesBegan(touches, with: event)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: PopupDelegate {
    func handleAnswerCorrect() {
        isUserInteractionEnabled = false
        
        layer.removeFromParent()
        popupframe.removeFromParent()
        
        if playerTurn == true {
            enemyHP.decreaseHP()
            playerTurn = false
        }
        else {
            player.dodge()
            playerTurn = true
        }
        
        addChild(attack)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }
        
        popupflag = "false"
        

        
    }
    
    func handleAnswerWrong() {
//        fatalError("Menunggu animasi avoid")
        
        isUserInteractionEnabled = false

        layer.removeFromParent()
        popupframe.removeFromParent()

        if playerTurn == true {
            enemy.dodge()
            playerTurn = false
        }
        else {
            playerHP.decreaseHP()
            playerTurn = true
        }
        
        addChild(attack)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }

        popupflag = "false"
    }
    
}
