//
//  SettingPopup.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 15/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class SettingPopup: SKNode {
    private var backgroundImg:SKSpriteNode!
    private var closeButton: SKSpriteNode!
    private var soundOn:SKSpriteNode!
    private var soundOff:SKSpriteNode!
    private var informationButton:SKSpriteNode!
    
    //variable
    var state:Bool = true
    
    
    init(position: CGPoint) {
        
        super.init()
        self.position = position
        //enable touching
        setupBackground()               // calling background
        setupCloseButton()              //calling button Close
        setupSoundOnButton()            //calling button soundOn
        setupSoundOffButton()           //calling button sound off
        setupInformationButton()        //calling button information
        self.isUserInteractionEnabled = true
        
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
            size = CGSize(width: screenWidth * 0.6, height: screenHeight * 0.5)
        } else {
            size = CGSize(width: screenWidth * 0.5, height: screenHeight * 0.7)
        }
        let textureBg = SKTexture(imageNamed: "frame_withTitle")
        let backgroundImg = SKSpriteNode(texture: textureBg, color: .clear
            , size: size)
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

    private func setupSoundOnButton()
    {
        let soundOnTexture = SKTexture(imageNamed: "icon_speakerOn")
        let legthIconSoundOn = UIScreen.main.bounds.height * 0.1
        let sizeIconSoundOn = CGSize(width: legthIconSoundOn, height: legthIconSoundOn)
        let soundOnButton = SKSpriteNode(texture: soundOnTexture, color: .clear, size: sizeIconSoundOn)
        //possition Y helper
        let iconY = UIScreen.main.bounds.height * 0.1
        soundOnButton.position = CGPoint(x: backgroundImg.frame.minX + legthIconSoundOn , y: iconY)
        soundOnButton.anchorPoint = CGPoint(x: 0, y: 0)
        self.soundOn = soundOnButton
        backgroundImg.addChild(soundOn)
        
    }
    
    private func setupSoundOffButton()
    {
        let soundOffTexture = SKTexture(imageNamed: "icon_speakerOff")
        let legthIconSoundOff = UIScreen.main.bounds.height * 0.1
        let sizeIconSoundOff = CGSize(width: legthIconSoundOff, height: legthIconSoundOff)
        let soundOffButton = SKSpriteNode(texture: soundOffTexture, color: .clear, size: sizeIconSoundOff)
        //setting position
        let iconInsetY = UIScreen.main.bounds.height * 0.1
        soundOffButton.position = CGPoint(x: backgroundImg.frame.minX + legthIconSoundOff , y: iconInsetY)
        soundOffButton.anchorPoint = CGPoint(x: 0, y: 0)
        self.soundOff = soundOffButton
//        backgroundImg.addChild(soundOff)
    }

    private func setupInformationButton()
    {
        let informationTexture = SKTexture(imageNamed: "icon_information")
        let legthIconInformation = UIScreen.main.bounds.height * 0.1
        let sizeIconInformaition = CGSize(width: legthIconInformation, height: legthIconInformation)
        let informationButton = SKSpriteNode(texture: informationTexture, color: .clear, size: sizeIconInformaition)
        //setting position
        let iconInsetY = soundOn.position.y - legthIconInformation * 1.3
        informationButton.position = CGPoint(x: soundOn.position.x, y: iconInsetY)
        informationButton.anchorPoint = CGPoint(x: 0, y: 0)
        self.informationButton = informationButton
        backgroundImg.addChild(informationButton)
        
    }
    
    func toggleSoundSetting(){
        if state == false {

            soundOff.removeFromParent()
            //textOff.removeFromParent()
            SKTransition.flipHorizontal(withDuration: 1)
            addChild(soundOn)
            //addChild(textOn)
            state = true
        } else
        {

            soundOn.removeFromParent()
            //textOn.removeFromParent()
            SKTransition.flipHorizontal(withDuration: 1)
            addChild(soundOff)
            //addChild(textOff)
            state = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            if closeButton.contains(location) {
                //remove from parent
                self.removeFromParent()
            } else if soundOn.contains(location) || soundOff.contains(location)
            {
                toggleSoundSetting()
            }
        }
    }
}
