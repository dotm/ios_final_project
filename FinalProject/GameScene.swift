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
    
    
    let playerNode = PlayerNode(position: CGPoint(x: 150, y: 120))
    let enemyNode = EnemyNode(position: CGPoint(x: 600, y: 150))
    let attack = Attack(position: CGPoint(x: 600, y: 150))
    let damage = Damage(position: CGPoint(x: 150, y: 120))
    
    let attackIcon = AttackIcon(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
    let defenseIcon = DefenseIcon(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
    
    var playerTurn: Bool = true

    private var popupframe: PopupFrame?
    
    private var popupflag: String = "false"
    
    private var playerHP: PlayerHP!
    private var enemyHP: EnemyHP!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        layer.position = CGPoint(x:  UIScreen.main.bounds.midX, y:  UIScreen.main.bounds.midY)
        
        let playerHP = PlayerHP(maxHP: 5) {
            self.defenseIcon.alpha = 0
            self.attackIcon.alpha = 0
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                self.addChild(layer)
            })
        }
        
        let enemyHP = EnemyHP(maxHP: 5) {
            self.defenseIcon.alpha = 0
            self.attackIcon.alpha = 0
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                self.addChild(layer)
            })
        }
        
        self.playerHP = playerHP
        self.enemyHP = enemyHP
        
        playerHP.position = CGPoint(x: UIScreen.main.bounds.minX + 60, y: UIScreen.main.bounds.maxY - 70)
        enemyHP.position = CGPoint(x: UIScreen.main.bounds.maxX - 300, y: UIScreen.main.bounds.maxY - 70)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        addChild(background)
        addChild(playerNode)
        addChild(enemyNode)
        
        addChild(playerHP)
        addChild(enemyHP)
        
        addChild(attackIcon)
        addChild(defenseIcon)
        
        if playerTurn == true {
            defenseIcon.alpha = 0
        }
        else {
            attackIcon.alpha = 1
        }

        
        playerNode.beginAnimation(state: .walk)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            
            if popupflag == "false" {
                guard attackIcon.contains(location) || defenseIcon.contains(location) else {return}
                
                displayIcon()
                
                addChild(layer)
                
                let timerBar = TimerBar(position: CGPoint(x: UIScreen.main.bounds.midX - 200, y: 30), duration: 5) {
                    self.handleAnswerWrong()
                }
                timerBar.name = "timer"
                addChild(timerBar)
                timerBar.changeSize()
                
                showPopUpQuiz()
                
                popupflag = "true"
            } else {
                // calling touch began in popupframe method
                popupframe?.touchesBegan(touches, with: event)
            }
            
        }

    }
    
    func showPopUpQuiz() {
        self.popupframe = PopupFrame(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY), gameDelegate: self)
        addChild(popupframe!)
    }
    
    func hidePopUpQuiz() {
        layer.removeFromParent()
        popupframe?.removeFromParent()
    }
    
    func displayIcon() {
        if playerTurn == true {
            attackIcon.alpha = 0
            defenseIcon.alpha = 1
        }
        else {
            attackIcon.alpha = 1
            defenseIcon.alpha = 0
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        popupframe?.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        popupframe?.touchesEnded(touches, with: event)
    }
}

extension GameScene: PopupDelegate {
    func handleAnswerCorrect() {
        
        isUserInteractionEnabled = false
        
        self.childNode(withName: "timer")?.removeFromParent()
        hidePopUpQuiz()
        
        if playerTurn == true {
            
            addChild(attack)
            attack.BeginAttack {
                self.attack.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            enemyHP.decreaseHP()
            playerTurn = false
        }
        else {
            
            addChild(damage)
            damage.BeginDamage {
                self.damage.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            playerNode.dodge()
            playerTurn = true
        }
        
        popupflag = "false"
    }
    
    func handleAnswerWrong() {
        isUserInteractionEnabled = false

        self.childNode(withName: "timer")?.removeFromParent()
        hidePopUpQuiz()

        if playerTurn == true {
            addChild(attack)
            attack.BeginAttack {
                self.attack.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            enemyNode.dodge()
            playerTurn = false
        }
        else {
            addChild(damage)
            damage.BeginDamage {
                self.damage.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            playerHP.decreaseHP()
            playerTurn = true
        }

        popupflag = "false"
    }
    
}
