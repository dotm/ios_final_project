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
    private var closeButton: SKSpriteNode!
    private var soundOn:SKSpriteNode!
    private var soundOff:SKSpriteNode!
    private var textOn:SKSpriteNode!
    private var textOff:SKSpriteNode!
    private var positionSoundBtn: CGPoint!
    
    //variable
    var state:Bool = true
    
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "frame_withTitle")
        super.init(texture: texture, color: .red, size: texture.size())
        self.position = position
        
        positionSoundBtn = CGPoint(x: -(self.frame.width/2)/2 - 175, y: self.frame.height/5)
        //setting button
        addCloseButton()
        setupSoundOnSetting()
        addChild(soundOn)
        addChild(textOn)
        setupSoundOffSetting()
        loadText()
        //enable touching
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCloseButton()
    {
        let closeButton = SKSpriteNode(texture: SKTexture(imageNamed: "icon_close"), color: .clear, size: CGSize(width: 64, height: 64))
        closeButton.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        closeButton.setScale(2.5)
        addChild(closeButton)
        self.closeButton = closeButton
    }
    
    func setupSoundOnSetting()
    {
        
        //button
        let soundOn = SKSpriteNode(texture: SKTexture(imageNamed: "icon_speakerOn"), color: .clear, size: CGSize(width: 44, height: 44))
        soundOn.position = positionSoundBtn
        soundOn.setScale(5.0)
        self.soundOn = soundOn
        
        //label
        let textSoundOn = SKSpriteNode(texture: SKTexture(imageNamed: "text_turnOn"), color: .clear, size: SKTexture(imageNamed: "text_turnOn").size())
        textSoundOn.position = CGPoint(x: self.frame.width/12 - 50, y: self.frame.height/4.5 - 40)
        textSoundOn.setScale(2.5)
        self.textOn = textSoundOn
    }
    
    func setupSoundOffSetting()
    {
        
        //button
        let soundOff = SKSpriteNode(texture: SKTexture(imageNamed: "icon_speakerOff"), color: .clear, size: CGSize(width: 44, height: 44))
        soundOff.setScale(5.0)
        soundOff.position = positionSoundBtn
        self.soundOff = soundOff
        
        //label
        let textSoundOff = SKSpriteNode(texture: SKTexture(imageNamed: "text_turnOff"), color: .clear, size: SKTexture(imageNamed: "text_turnOff").size())
        textSoundOff.position = CGPoint(x: self.frame.width/12 - 50, y: self.frame.height/4.5 - 40)
        textSoundOff.setScale(2.5)
        self.textOff = textSoundOff
    }
    
    func loadText()
    {
        //text title
        let textTitle = SKSpriteNode(texture: SKTexture(imageNamed: "text_setting"), color: .blue , size: SKTexture.init(imageNamed: "text_setting").size())
        textTitle.position = CGPoint(x: 0, y: self.frame.height/2 - 115)
        textTitle.setScale(2.5)
        addChild(textTitle)
        //information text
        let information = SKSpriteNode(texture: SKTexture(imageNamed: "icon_information"), color: .clear, size: CGSize(width: 44, height: 44))
        
        information.position = CGPoint(x: -(self.frame.width/2)/2 - 175, y: -(self.frame.height/2)/5 + 125)
        information.setScale(5.0)
        addChild(information)
        
        let textInformation = SKSpriteNode(texture: SKTexture(imageNamed: "text_information"), color: .clear, size: SKTexture(imageNamed: "text_information").size())
        textInformation.position = CGPoint(x: 0 , y: 0)
        textInformation.setScale(2.5)
        addChild(textInformation)
    }
    
    func toggleSoundSetting(){
        if state == false {
            
            soundOff.removeFromParent()
            textOff.removeFromParent()
            SKTransition.flipHorizontal(withDuration: 1)
            addChild(soundOn)
            addChild(textOn)
            state = true
        } else
        {
            
            soundOn.removeFromParent()
            textOn.removeFromParent()
            SKTransition.flipHorizontal(withDuration: 1)
            addChild(soundOff)
            addChild(textOff)
            state = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if closeButton.contains(location) {
                //clossing popup
                self.removeFromParent()
            } else if soundOn.contains(location) || soundOff.contains(location) {
                toggleSoundSetting()
            }
        }
    }
    
}

