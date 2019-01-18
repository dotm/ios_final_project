//
//  ChooseMode.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 17/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit


class ChooseMode: SKNode {
    private var backgroundImg:SKSpriteNode!
    private var closeButton:SKSpriteNode!
    
    init(position:CGPoint) {
        super.init()
        self.position = position
        setupBackground()
        setupCloseButton()
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground()
    {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let size:CGSize
        if UIDevice.current.is_iPad() {
            size = CGSize(width: screenWidth * 0.7, height: screenHeight * 0.6)
        } else {
            size = CGSize(width: screenWidth * 0.5, height: screenHeight * 0.7)
        }
        let textureBg = SKTexture(imageNamed: "frame_chooseMode")
        let backgroundImg = SKSpriteNode(texture: textureBg, color: .clear, size: size)
        addChild(backgroundImg)
        self.backgroundImg = backgroundImg
    }
    
    private func setupCloseButton()
    {
        let closeButtonTexture = SKTexture(imageNamed: "icon_close")
        let lengthIcon = UIScreen.main.bounds.height * 0.1
        let sizeIcon:CGSize = CGSize(width: lengthIcon, height: lengthIcon)
        let closeButton = SKSpriteNode(texture: closeButtonTexture, color: .clear, size: sizeIcon )
        closeButton.position = CGPoint(x: backgroundImg.frame.maxX, y: backgroundImg.frame.maxY)
        closeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.closeButton = closeButton
        backgroundImg.addChild(closeButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if closeButton.contains(location) {
                self.removeFromParent()
//                if let child = parent!.childNode(withName: "layer") as? SKSpriteNode {
//                    child.removeFromParent()
//                }
            }
        }
    }
    
}
