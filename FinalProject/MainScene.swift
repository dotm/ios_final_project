//
//  MainScene.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 14/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics

fileprivate let layer = SKSpriteNode(color: UIColor(white: 0, alpha: 0.5), size: UIScreen.main.bounds.size)

class MainScene: SKScene {
    let background = SKSpriteNode(imageNamed: "background_home")
    var playIcon:PlayIcon?
    var settingIcon: SettingIcon?
    var historyIcon: HistoryIcon?
    var helpIcon:HelpIcon?
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        //background
        background.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY+50)
        background.setScale(0.60)
        
        //play icon button modifier
        playIcon = PlayIcon(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
        playIcon?.setScale(0.56)
        
        //setting icon button modifier
        settingIcon = SettingIcon(position: CGPoint(x: UIScreen.main.bounds.maxX - 35, y: UIScreen.main.bounds.maxY - 35 ))
        settingIcon?.setScale(0.2)
        
        //history icon button modifier
        historyIcon = HistoryIcon(position: CGPoint(x: UIScreen.main.bounds.maxX - 35, y: UIScreen.main.bounds.maxY - 85 ))
        historyIcon?.setScale(0.2)
        
        //help icon button modifier
        helpIcon = HelpIcon(position: CGPoint(x: UIScreen.main.bounds.maxX - 35, y: UIScreen.main.bounds.maxY - 135 ))
        helpIcon?.setScale(0.2)
        
        
        //adding to node
        addChild(background)
        addChild(playIcon!)
        addChild(settingIcon!)
        addChild(historyIcon!)
        addChild(helpIcon!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playIcon?.touchesBegan(touches, with: event)
        for touch:AnyObject in touches
        {
            let location = touch.location(in: self)
            if playIcon!.contains(location) {
                print("play icon touches")
                let gameScene = GameScene(size: size, stage: stage1A)
                self.scene?.view?.presentScene(gameScene, transition: .fade(withDuration: 0.8))
                
            }
            else if settingIcon!.contains(location)
            {
                print("settingIcon touches")
                let settingPopup = SettingPopup(position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
                settingPopup.setScale(0.2)
                settingPopup.touchesBegan(touches, with: event)
                addChild(settingPopup)
                
            }
            else if historyIcon!.contains(location)
            {
                print("history icon are touches")
            }
            else if helpIcon!.contains(location)
            {
                print("help icon are touches")
            }
            else{
                print("touching others")
            }
        }
    }
}

