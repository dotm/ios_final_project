//
//  Utilities.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 17/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//


import UIKit

extension UIDevice {
    func is_iPad() -> Bool {
        return self.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    func isNot_iPad() -> Bool {
        return !is_iPad()
    }
}

extension CGSize {
    static func * (multiplier: Double, size: CGSize) -> CGSize {
        return size * multiplier
    }
    static func * (size: CGSize, multiplier: Double) -> CGSize {
        return CGSize(width: size.width * CGFloat(multiplier), height: size.height * CGFloat(multiplier))
    }
    static func / (size: CGSize, multiplier: Double) -> CGSize {
        return CGSize(width: size.width / CGFloat(multiplier), height: size.height / CGFloat(multiplier))
    }
}


