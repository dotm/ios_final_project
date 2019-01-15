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
    
    let attack = Attack(position: CGPoint(x: 600, y: 150))
    let damage = Damage(position: CGPoint(x: 150, y: 120))
    
    let attackIcon = AttackIcon(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
    let defenseIcon = DefenseIcon(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
    
    var playerTurn: Bool = true

    private var popupframe: PopupFrame?
    
    private var popupflag: String = "false"
    
    private var playerHP: PlayerHP!
    private var enemyHP: EnemyHP!
    
    var stage: Stage!
    var playerNode: PlayerNode!
    var enemyNode: EnemyNode!
    var background: SKSpriteNode!
    
    
    init(size: CGSize, stage: Stage) {
        self.stage = stage
        
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.minX + (UIScreen.main.bounds.width * 0.15), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)))
        let enemyNode = EnemyNode(position: CGPoint(x: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.width * 0.25), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)), enemy: stage.mobSpawn) //HEREEE
        self.playerNode = playerNode
        self.enemyNode = enemyNode
        
        let background = SKSpriteNode(imageNamed: stage.textureBackground) //HERE
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
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
        
        let gapHP = UIScreen.main.bounds.width * 0.05
        
        playerHP.anchorPoint = CGPoint(x: 0, y: 0)
        playerHP.position = CGPoint(x: UIScreen.main.bounds.midX - playerHP.size.width - gapHP, y: UIScreen.main.bounds.maxY - (UIScreen.main.bounds.height * 0.2))

        enemyHP.anchorPoint = CGPoint(x: 0, y: 0)
        enemyHP.position = CGPoint(x: UIScreen.main.bounds.midX + gapHP, y: UIScreen.main.bounds.maxY - (UIScreen.main.bounds.height * 0.2))
        
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
        enemyNode.beginAnimation(state: .walk)
        
        BackgroundMusicPlayer.playBattleSceneSong()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            
            if popupflag == "false" {
                guard attackIcon.contains(location) || defenseIcon.contains(location) else {return}
                
                displayIcon()
                
                addChild(layer)
                
                let timerBar = TimerBar(position: CGPoint(x: UIScreen.main.bounds.midX, y: 30), duration: stage.quizTime) //HERE
                {
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
        self.popupframe = PopupFrame(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY), gameDelegate: self, category: stage.quizCategory)
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
        
        attackIcon.alpha = 0
        defenseIcon.alpha = 0
        
        if playerTurn == true {
            playerNode.beginAnimation(state: .attack)
            addChild(attack)
            attack.BeginAttack {
                self.attack.removeFromParent()
                self.enemyNode.beginAnimation(state: .stagger)
                self.isUserInteractionEnabled = true
            }
            
            enemyHP.decreaseHP()
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.enemyNode.beginAnimation(state: .walk)
                self.playerNode.beginAnimation(state: .walk)
                self.defenseIcon.alpha = 1
            })
            playerTurn = false
        }
        else {
            
            playerNode.beginAnimation(state: .defense)
            enemyNode.beginAnimation(state: .attack)
            addChild(damage)
            damage.BeginDamage {
                self.damage.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.playerNode.beginAnimation(state: .walk)
                self.enemyNode.beginAnimation(state: .walk)
                self.attackIcon.alpha = 1
                self.isUserInteractionEnabled = true
            })
            playerTurn = true
        }
        
        popupflag = "false"
    }
    
    func handleAnswerWrong() {
        isUserInteractionEnabled = false

        self.childNode(withName: "timer")?.removeFromParent()
        hidePopUpQuiz()
        
        attackIcon.alpha = 0
        defenseIcon.alpha = 0

        if playerTurn == true {
            addChild(attack)
            playerNode.beginAnimation(state: .attack)
            self.enemyNode.beginAnimation(state: .defense)
            attack.BeginAttack {
                self.attack.removeFromParent()
                self.isUserInteractionEnabled = true
            }
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.playerNode.beginAnimation(state: .walk)
                self.enemyNode.beginAnimation(state: .walk)
                self.defenseIcon.alpha = 1
            })
            playerTurn = false
        }
        else {
            addChild(damage)
            enemyNode.beginAnimation(state: .attack)
            damage.BeginDamage {
                self.damage.removeFromParent()
                self.playerNode.beginAnimation(state: .stagger)
                self.isUserInteractionEnabled = true
            }
            
            playerHP.decreaseHP()
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.playerNode.beginAnimation(state: .walk)
                self.enemyNode.beginAnimation(state: .walk)
                self.attackIcon.alpha = 1
                self.isUserInteractionEnabled = true
            })
            playerTurn = true
        }

        popupflag = "false"
    }
    
}
