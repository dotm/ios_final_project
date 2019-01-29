//
//  EnemyGroupNode.swift
//  FinalProject
//
//  Created by Yuvens Putra Barata on 26/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyGroupNode: SKSpriteNode {
    
    var arrEnemy: [EnemyNode] = []
    var indexEnemy: Int = 0
    
    var duration: Double = 0.2
    var enemyAmount: Int!
    
    private var onEmptyEnemy: (()->())!
    
    init(position: CGPoint, enemyAmount: Int, enemy: Enemy, onEmptyEnemy: @escaping ()->() ) {
        
        let width: CGFloat = UIScreen.main.bounds.height * 0.5
        let height: CGFloat = UIScreen.main.bounds.height * 0.3
        
        super.init(texture: nil, color: .clear, size: CGSize(width: width, height: height))
        self.position = position
        self.onEmptyEnemy = onEmptyEnemy
        self.enemyAmount = enemyAmount
        
        print(111, UIScreen.main.bounds.maxX)
        print(222, UIScreen.main.bounds.maxY)
        
        for _ in 0...enemyAmount - 1 {

            let x = CGFloat.random(in: (-self.frame.width/3)...(self.frame.width/3))
            let y = CGFloat.random(in: (-self.frame.width/3)...(self.frame.width/3))

            let enemyNode = EnemyNode(position: CGPoint(x: x, y: y), enemy: enemy)
            print(777,x)
            print(666,y)

            arrEnemy.append(enemyNode)
            addChild(enemyNode)
            
            enemyNode.beginAnimation(state: .walk)
        }
        
        print(999,self.frame.minX,self.frame.maxX)
        print(888,self.frame.minY,self.frame.maxY)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decreaseEnemy() {
        
        let currentArr = arrEnemy[indexEnemy]
        
        currentArr.dies()
        
        indexEnemy = indexEnemy + 1
        
        if indexEnemy == enemyAmount {
            onEmptyEnemy()
        }
    }
    
    func defense() {
        for i in 0...arrEnemy.count - 1 {
            arrEnemy[i].defense()
        }
    }
}
