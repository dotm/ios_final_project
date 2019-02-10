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
        
        setupBackground()
        setupEnemyGroupNode()
        setupPlayerNode()
        setupAttack()
        
        showPopUpQuiz()
        
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
        attack.BeginAttack {
            self.enemyGroupNode.decreaseEnemy()
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                self.playerNode.beginAnimation(state: .walk)
                self.showPopUpQuiz()
                
                
                self.isUserInteractionEnabled = true
            })
        }
    }
    
    func setupEnemyGroupNode() {
        let enemyGroupNode = EnemyGroupNode(position: CGPoint(x: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.width * 0.25), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.3)), enemyAmount: stage.mobSpawn.enemyHP, enemy: stage.mobSpawn) {
            
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
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
        
        guard let snowParticle = SKEmitterNode(fileNamed: "SnowParticle") else { return }
        snowParticle.position = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
        
        self.addChild(snowParticle)
    }
    
    func setupPlayerNode() {
        let playerNode = PlayerNode(position: CGPoint(x: UIScreen.main.bounds.minX + (UIScreen.main.bounds.width * 0.15), y: UIScreen.main.bounds.minY + (UIScreen.main.bounds.height * 0.4)))
        self.playerNode = playerNode
        addChild(playerNode)
    }
    
    func setupAttack() {
        let attack: Attack!
        
        attack = Attack(position: CGPoint(x: playerNode.position.x, y: UIScreen.main.bounds.midY / 1.2))
        
        addChild(attack)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popupframe?.touchesBegan(touches, with: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        popupframe?.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        popupframe?.touchesEnded(touches, with: event)
    }
}
