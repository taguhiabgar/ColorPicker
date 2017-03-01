//
//  UIColor.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func randomColor() -> UIColor {
        return UIColor(red: randomColorValue(), green: randomColorValue(), blue: randomColorValue(), alpha: randomColorValue())
    }
    
    static private func randomColorValue() -> CGFloat {
        let number = arc4random() % 255
        return CGFloat(number) / 255.0
    }
}
