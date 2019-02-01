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
    
    //MARK: VARIABLES

    private var popupframe: PopupFrame?
    private var popupflag: String = "false"
    
    var stage: Stage!
    var playerNode: PlayerNode!
    var enemyGroupNode: EnemyGroupNode!
    var background: SKSpriteNode!
    var attack: Attack!
    
    //MARK: INITIALIZER
    init(size: CGSize, stage: Stage) {
        self.stage = stage
        
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        setupAttack()
        setupBackground()
        setupEnemyGroupNode()
        setupPlayerNode()
        
        showPopUpQuiz()
        
        popupflag = "true"
        
        playerNode.beginAnimation(state: .walk)
        
        BackgroundMusicPlayer.playBattleSceneSong()
    }
}


//MARK: FUNCTION
extension GameScene: PopupDelegate {
    func handleAnswerCorrect() {
        
        isUserInteractionEnabled = false
        
        hidePopUpQuiz()
        playerNode.beginAnimation(state: .attack)
        addChild(attack)
        attack.BeginAttack {
            
            self.attack.removeFromParent()
            self.enemyGroupNode.decreaseEnemy()
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.playerNode.beginAnimation(state: .walk)
                self.showPopUpQuiz()
                
                
                self.isUserInteractionEnabled = true
            })
            
            self.popupflag = "false"
        }
    }
    
    func handleAnswerWrong() {
        isUserInteractionEnabled = false

        hidePopUpQuiz()
        
        addChild(attack)
        playerNode.beginAnimation(state: .attack)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }
        
        enemyGroupNode.defense()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.playerNode.beginAnimation(state: .walk)
            self.isUserInteractionEnabled = true
            self.showPopUpQuiz()
        })

        popupflag = "false"
    }
    
    func setupEnemyGroupNode() {
        let enemyGroupNode = EnemyGroupNode(position: CGPoint(x: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.width * 0.25), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.3)), enemyAmount: stage.mobSpawn.enemyHP, enemy: stage.mobSpawn) {
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                let victoryScene = WinFrame(size: self.scene!.size, currentStage: self.stage)
                self.scene?.view?.presentScene(victoryScene, transition: .fade(withDuration: 0.8))
            })
        }
        
        self.enemyGroupNode = enemyGroupNode
        addChild(enemyGroupNode)
    }
    
    func setupBackground() {
        let background: SKSpriteNode!
        
        if UIDevice.current.is_iPad(){
            background = SKSpriteNode(imageNamed: stage.ipadBattleBackground)
        }
        else {
            background = SKSpriteNode(imageNamed: stage.iphoneBattleBackground)
        }
        
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        addChild(background)
    }
    
    func setupPlayerNode() {
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.minX + (UIScreen.main.bounds.width * 0.15), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)))
        self.playerNode = playerNode
        addChild(playerNode)
    }
    
    func setupAttack() {
        let attack: Attack!
        
        if UIDevice.current.is_iPad(){
            attack = Attack(position: CGPoint(x: UIScreen.main.bounds.midX + (UIScreen.main.bounds.midX * 1.2), y: UIScreen.main.bounds.midY / 1.2))
        }
        else {
            attack = Attack(position: CGPoint(x: UIScreen.main.bounds.midX + (UIScreen.main.bounds.midX/2), y: UIScreen.main.bounds.midY / 1.2))
        }
        
        attack.alpha = 0.7
        self.attack = attack
    }
    
    func showPopUpQuiz() {
        self.popupframe = PopupFrame(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY), gameDelegate: self, category: stage.quizCategory)
        addChild(popupframe!)
    }
    
    func hidePopUpQuiz() {
        popupframe?.removeFromParent()
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
