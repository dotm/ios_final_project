//
//  PopupQuiz.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 02/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit

class DummyPopupQuiz: SKNode {
    
    var gameDelegate:PopupDelegate?
    private var label : SKLabelNode?
    private var frameQuestion : SKSpriteNode?
    
    // generate circle node
    let shape:SKShapeNode = generateShape(shape: .circle)
    let shape2:SKShapeNode = generateShape(shape: .rectangle)
    
    init(size: CGSize) {
        super.init()
        // load the setup function
        loadSetup(size: size)
        //set userinteractions for PopupQuiz
        isUserInteractionEnabled = true
//        print("\(size)")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSetup(size:CGSize) {
        
        // create frame question with color black and size from parameter
        frameQuestion = SKSpriteNode(color: .black, size: size)
        // setting frame question possition
        frameQuestion?.position = CGPoint(x: 0, y: 0)
        // insert frame to popoup quiz node
        self.addChild(frameQuestion!)
        
        /* Remark: changing property */
        
        // setting color shape
        shape.fillColor = .blue
        shape2.fillColor = .yellow
        
        // setting position shape
        shape.position = CGPoint(x: -20, y: 0)
        shape2.position = CGPoint(x: 20 , y: -20 )
        
        // add shape to node frame questions
        frameQuestion!.addChild(shape)
        frameQuestion!.addChild(shape2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched in answer")
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if shape.contains(location) {
                print("shape 1 touched")
                gameDelegate?.handleAnswerCorrect()
            }
            else if shape2.contains(location) {
                print("shape 2 touched")
                gameDelegate?.handleAnswerWrong()
            }
            else {
                print("you are touching other")
            }
        }
    }
}
