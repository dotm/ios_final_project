//
//  PopupQuiz.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 02/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol PopupDelegate {
    func handleAnswerCorrect()
    func handleAnswerWrong()
}
class PopupQuiz: SKNode {
    
    //var gameDelegate:PopupDelegate?
    private var label : SKLabelNode?
    private var button : SKSpriteNode?
    private var titleQuestion: SKLabelNode?
    private var titleAnswerA: SKLabelNode?
    private var titleAnswerB: SKLabelNode?
    private var titleAnswerC: SKLabelNode?
    private var titleAnswerD: SKLabelNode?
    private var questions: [QnA] = []
    private var question: QnA?
    private var indexQnA:Int = 0
    
    
    
    func loadSetup()
    {
        question = QnA(questions: "1+1", answers: ["2","3","5","8"], correctIndex: 0)
        questions.append(question!)
        question = QnA(questions: "8+1", answers: ["6","7","9","1"], correctIndex: 2)
        questions.append(question!)
        button = SKSpriteNode(color: .black, size: CGSize(width: 375, height: 200))

        button?.position = CGPoint(x: 0, y: 0)
        self.addChild(button!)
        var shape:SKShapeNode = generateShape(shape: .circle)
        shape.fillColor = .blue
        self.addChild(shape)
    }
    func loadQuestions(index:Int)
    {
      
        guard let question = questions[index].question else {return}
        titleQuestion = SKLabelNode.init(text: "\(question)")
        titleQuestion?.position = CGPoint(x: 0, y: 50)
        button!.addChild(titleQuestion!)
        print("button")
        titleAnswerA = SKLabelNode.init(text: "\(questions[index].answer[0])")
        titleAnswerA?.position = CGPoint(x: 0-50, y: 0)
        button!.addChild(titleAnswerA!)

        titleAnswerB = SKLabelNode.init(text: "\(questions[index].answer[1])")
        titleAnswerB?.position = CGPoint(x: 0, y: 0)
        button?.addChild(titleAnswerB!)
        titleAnswerC = SKLabelNode.init(text: "\(questions[index].answer[2])")
        titleAnswerC?.position = CGPoint(x: 50, y: 0)
        button?.addChild(titleAnswerC!)
        titleAnswerD = SKLabelNode.init(text: "\(questions[index].answer[3])")
        titleAnswerD?.position = CGPoint(x: 100, y: 0)
        button?.addChild(titleAnswerD!)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
//            guard let button = button else {return}
            guard let title = titleAnswerA else {return}
            //guard let gameDelegate = gameDelegate else {return}
            if title.contains(location)
            {
                print("buttonTouched")
                //gameDelegate.handleAnswerCorrect()
            }
        }
    }
}
