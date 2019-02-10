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
    func feedbackSupportLevel() -> NSNumber {
        return (self.value(forKey: "_feedbackSupportLevel") as? NSNumber)!
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

extension String {
    static func randomOneCharacter(length: Int = 1) -> String {
        let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

