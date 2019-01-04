//
//  ShapeQuestion.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 04/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

enum Shape {
    case rectangle
    case square
    case circle
}

func generateShape(shape:Shape) -> SKShapeNode {
    switch shape {
    case .rectangle :
        return SKShapeNode(rect: CGRect(x: 0, y: 0, width: 10, height: 30))
    case .square:
        return SKShapeNode(rect: CGRect(x: 0, y: 0, width: 40, height: 40))
    case .circle:
        return SKShapeNode(ellipseOf: CGSize(width: 40, height: 40))
    }
}
