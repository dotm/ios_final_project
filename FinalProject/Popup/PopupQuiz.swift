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
    private var frameQuestion : SKSpriteNode?
    private var titleQuestion: SKLabelNode?
    private var titleAnswerA: SKLabelNode?
    private var titleAnswerB: SKLabelNode?
    private var titleAnswerC: SKLabelNode?
    private var titleAnswerD: SKLabelNode?
    private var questions: [QnA] = []
    private var question: QnA?
    private var indexQnA:Int = 0
    
    
    init(size: CGSize) {
        super.init()
        loadSetup(size: size)
        loadQuestions(index: 0)
        print("\(size)")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadSetup(size:CGSize)
    {
        question = QnA(questions: "1+1", answers: ["2","3","5","8"], correctIndex: 0)
        questions.append(question!)
        question = QnA(questions: "8+1", answers: ["6","7","9","1"], correctIndex: 2)
        questions.append(question!)
        frameQuestion = SKSpriteNode(color: .black, size: size)

        frameQuestion?.position = CGPoint(x: 0, y: 0)
        self.addChild(frameQuestion!)
        var shape:SKShapeNode = generateShape(shape: .circle)
        shape.fillColor = .blue
        shape.position = CGPoint(x: 0, y: 0)
        self.addChild(shape)
    }
    func loadQuestions(index:Int)
    {
      
        guard let question = questions[index].question else {return}
        titleQuestion = SKLabelNode.init(text: "\(question)")
        titleQuestion?.position = CGPoint(x: 0, y: 50)
        frameQuestion!.addChild(titleQuestion!)
        print("button")
        titleAnswerA = SKLabelNode.init(text: "\(questions[index].answer[0])")
        titleAnswerA?.position = CGPoint(x: 0-50, y: 0)
        frameQuestion!.addChild(titleAnswerA!)

        titleAnswerB = SKLabelNode.init(text: "\(questions[index].answer[1])")
        titleAnswerB?.position = CGPoint(x: 0, y: 0)
        frameQuestion?.addChild(titleAnswerB!)
        titleAnswerC = SKLabelNode.init(text: "\(questions[index].answer[2])")
        titleAnswerC?.position = CGPoint(x: 50, y: 0)
        frameQuestion?.addChild(titleAnswerC!)
        titleAnswerD = SKLabelNode.init(text: "\(questions[index].answer[3])")
        titleAnswerD?.position = CGPoint(x: 100, y: 0)
        frameQuestion?.addChild(titleAnswerD!)
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
