//
//  UIColor.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Public Methods
    
    static func randomColor() -> UIColor {
        return UIColor(red: randomColorValue(), green: randomColorValue(), blue: randomColorValue(), alpha: randomColorValue())
    }
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    // MARK: - Private Methods
    
    static private func randomColorValue() -> CGFloat {
        let number = arc4random() % 255
        return CGFloat(number) / 255.0
    }
}
