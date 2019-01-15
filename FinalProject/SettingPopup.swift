//
//  SettingPopup.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 15/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class SettingPopup: SKSpriteNode {
    
    var soundOn = SKSpriteNode(texture: SKTexture(imageNamed: "icon_speakerOn"), color: .clear, size: CGSize(width: 44, height: 44))
    var soundOff = SKSpriteNode(texture: SKTexture(imageNamed: "icon_speakerOff"), color: .clear, size: CGSize(width: 44, height: 44))
    var information = SKSpriteNode(texture: SKTexture(imageNamed: "icon_information"), color: .clear, size: CGSize(width: 44, height: 44))
    var closeButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_close"), color: .clear, size: CGSize(width: 64, height: 64))
    
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "frame_withTitle")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        
        //setting button
        closeButton.position = CGPoint(x: UIScreen.main.bounds.maxX+50, y: UIScreen.main.bounds.maxY+270)
        closeButton.setScale(2.5)
        
        
        
        //addchildnode
        addChild(closeButton)

        
        //enable touching
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if closeButton.contains(location) {
                //clossing popup
                self.removeFromParent()
            }
        }
    }
}

