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
    /* Mark: handle shape*/
    case rectangle
    case square
    case circle
}

func generateShape(shape:Shape) -> SKShapeNode {
    switch shape {
    case .rectangle :
        // generate shape rectangle with size
        return SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 40))
    case .square:
        // generate shape square with size
        return SKShapeNode(rect: CGRect(x: 0, y: 0, width: 40, height: 40))
    case .circle:
        // generate shape circle with size
        return SKShapeNode(ellipseOf: CGSize(width: 40, height: 40))
    }
}
