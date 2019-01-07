//
//  EnemyHP.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 07/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate let barHeight: CGFloat = 30
fileprivate let barWidth: CGFloat = 300

class EnemyHP: SKNode {
    
    let barHP  = SKShapeNode(rect: CGRect(x: UIScreen.main.bounds.maxX - 60 - barWidth, y: UIScreen.main.bounds.maxY - 70, width: barWidth, height: barHeight), cornerRadius: 0.5)
    
    init(MaxHP: Int) {
        super.init()
        
        barHP.fillColor = .red
        addChild(barHP)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
