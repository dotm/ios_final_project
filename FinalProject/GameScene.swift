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
    
    private var enemyHP: EnemyHP!
    
    var stage: Stage!
    var playerNode: PlayerNode!
    var enemyNode: EnemyNode!
    var background: SKSpriteNode!
    
    var winFrame: WinFrame!
    
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
        
        let enemyHP = EnemyHP(maxHP: stage.mobSpawn.enemyHP) {
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                let victoryScene = WinFrame(size: self.scene!.size, currentStage: self.stage)
                self.scene?.view?.presentScene(victoryScene, transition: .fade(withDuration: 0.8))
            })
        }
        
        self.enemyHP = enemyHP
        
        let gapHP = UIScreen.main.bounds.width * 0.05

        enemyHP.anchorPoint = CGPoint(x: 0, y: 0)
        enemyHP.position = CGPoint(x: UIScreen.main.bounds.midX + gapHP, y: UIScreen.main.bounds.maxY - (UIScreen.main.bounds.height * 0.2))
        
        addChild(background)
        addChild(playerNode)
        addChild(enemyNode)
        
        addChild(enemyHP)
        
        showPopUpQuiz()
        
        popupflag = "true"

        
        playerNode.beginAnimation(state: .walk)
        enemyNode.beginAnimation(state: .walk)
        
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
        self.enemyNode.beginAnimation(state: .stagger)
        addChild(attack)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }
        
        enemyHP.decreaseHP()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.enemyNode.beginAnimation(state: .walk)
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
        self.enemyNode.beginAnimation(state: .defense)
        attack.BeginAttack {
            self.attack.removeFromParent()
            self.isUserInteractionEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.playerNode.beginAnimation(state: .walk)
            self.enemyNode.beginAnimation(state: .walk)
            self.isUserInteractionEnabled = true
            self.showPopUpQuiz()
        })

        popupflag = "false"
    }
    
}
