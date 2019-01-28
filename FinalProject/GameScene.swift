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
    
    let attack = Attack(position: CGPoint(x: UIScreen.main.bounds.width * 0.83, y: UIScreen.main.bounds.height * 0.5))

    private var popupframe: PopupFrame?
    
    private var popupflag: String = "false"
    
    var stage: Stage!
    var playerNode: PlayerNode!
    var enemyGroupNode: EnemyGroupNode!
    
    var background: SKSpriteNode!
    
    var winFrame: WinFrame!
    
    init(size: CGSize, stage: Stage) {
        self.stage = stage
        
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.minX + (UIScreen.main.bounds.width * 0.15), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)))
        
        self.playerNode = playerNode

        let background = SKSpriteNode(imageNamed: stage.textureBackground)
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.background = background
        
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        let enemyGroupNode = EnemyGroupNode(position: CGPoint(x: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.width * 0.25), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)), enemyAmount: stage.mobSpawn.enemyHP, enemy: stage.mobSpawn) {
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                let victoryScene = WinFrame(size: self.scene!.size, currentStage: self.stage)
                self.scene?.view?.presentScene(victoryScene, transition: .fade(withDuration: 0.8))
            })
        }
        
        self.enemyGroupNode = enemyGroupNode
        
        addChild(background)
        addChild(playerNode)
        addChild(enemyGroupNode)
        
        showPopUpQuiz()
        
        popupflag = "true"

        
        playerNode.beginAnimation(state: .walk)
        
        BackgroundMusicPlayer.playBattleSceneSong()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

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

extension GameScene: PopupDelegate {
    func handleAnswerCorrect() {
        
        isUserInteractionEnabled = false

        hidePopUpQuiz()
        playerNode.beginAnimation(state: .attack)
        addChild(attack)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }
        
        enemyGroupNode.decreaseEnemy()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.playerNode.beginAnimation(state: .walk)
            self.showPopUpQuiz()
        })
        
        popupflag = "false"
        
        
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
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.playerNode.beginAnimation(state: .walk)
            self.isUserInteractionEnabled = true
            self.showPopUpQuiz()
        })

        popupflag = "false"
    }
    
}
