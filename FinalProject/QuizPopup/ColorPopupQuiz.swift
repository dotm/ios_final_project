//
//  ColorPopupQuiz.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 08/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class ColorPopupQuiz: BasePopupQuiz {
    
    //mark: Variable declared
    var arrayColor:[UIColor]  = [UIColor.red, UIColor.blue , UIColor.yellow , UIColor.green , UIColor.cyan, UIColor.magenta, UIColor.purple]
    var frameQuestions: SKSpriteNode?
    var currentTouchMoved: SKNode?
    var correctColor : UIColor?
    var correctPos: CGPoint?
    
    init(size:CGSize) {
        //generate frame
        frameQuestions = SKSpriteNode(texture: nil,color: .clear, size: size)
        super.init()
        addChild(frameQuestions!)
        
        //user interaction
        self.isUserInteractionEnabled = true
        
        //generate soal
        let soal = sliceArray(arrayColors: arrayColor)
        print("ini adalah hasil slice",soal)
        generateQuestion(warna: soal.last!)
        generateAnswer(warna: soal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateQuestion(warna:UIColor) {
        //making question node
        let questions:SKSpriteNode = SKSpriteNode(color: warna, size: CGSize(width: 50, height: 50))
        questions.position = CGPoint(x: 0, y: 30)
        correctPos = questions.position
        correctColor = warna
        frameQuestions?.addChild(questions)
        
    }
    
    func generateAnswer(warna :[UIColor]) {
        var arrayDuplicate = warna
        arrayDuplicate.shuffle()
        var pos = -80
        for i in 0..<arrayDuplicate.count
        {
            let answer = SKSpriteNode(color: arrayDuplicate[i], size: CGSize(width: 40, height: 40))
            answer.position = CGPoint(x: pos , y: -30)
            answer.name = "answer"
            self.frameQuestions?.addChild(answer)
            pos = pos + 60
            
        }
        
    }
    
    func sliceArray(arrayColors:[UIColor])->[UIColor] {
        var newArray = arrayColors
        newArray.shuffle()
        print(newArray)
        var newQuestion:[UIColor] = []
        
        for _ in 0...3 {
            newQuestion.append(newArray.popLast()!)
        }
        
        print(newQuestion)
        return newQuestion
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position_inScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: position_inScene)

        currentTouchMoved = touchedNodes.first { (node) -> Bool in
            return node.name == "answer"
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: frameQuestions!)
            
            currentTouchMoved?.position.x = location.x
            currentTouchMoved?.position.y = location.y
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currTouch = currentTouchMoved as! SKSpriteNode? else { print("WTF") ;return}
        let colorMatched = currTouch.color == correctColor
        if colorMatched && nearDrop(currTouch.position)
        {
            gameDelegate?.handleAnswerCorrect()
        }
        else
        {
            
        }
        currentTouchMoved = nil
        
    }
    
    func nearDrop(_ coordinatePoint: CGPoint)-> Bool
    {
        guard let questionPos = correctPos else {return false}
        let difference_inX = abs(coordinatePoint.x - questionPos.x)
        let difference_inY = abs(coordinatePoint.y - questionPos.y)
        
        if difference_inX <= 10 && difference_inY <= 10
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}
