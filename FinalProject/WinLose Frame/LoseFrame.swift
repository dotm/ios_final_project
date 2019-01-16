//
//  LoseFrame.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 16/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class LoseFrame: SKSpriteNode {
    
    private var returnButton: SKSpriteNode!
    private var replayButton: SKSpriteNode!
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "frame_lose")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
        setupReplayButton()
        setupReturnButton()
        
        if UIScreen.main.bounds.height < 500 {
            self.setScale(0.4)
        }
        else {
            self.setScale(0.7)
        }
    }
    
    func setupReturnButton(){
        let returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_exit"), color: .clear, size: CGSize(width: (self.frame.width / 7), height: (self.frame.width / 7)))
        
        returnButton.position = CGPoint(x: -(self.frame.width / 4), y: -(self.frame.height / 2))
        
        addChild(returnButton)
        
        self.returnButton = returnButton
    }
    
    func setupReplayButton() {
        let replayButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_replay"), color: .clear, size: CGSize(width: (self.frame.width / 7), height: (self.frame.width / 7)))
        
        replayButton.position = CGPoint(x: self.frame.width / 4, y: -(self.frame.height / 2))
        
        addChild(replayButton)
        
        self.replayButton = replayButton
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if returnButton.contains(location) {
                print("RETURN")
            }
            else if replayButton.contains(location) {
                print("REPLAY")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
