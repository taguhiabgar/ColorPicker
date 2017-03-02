//
//  CGRect.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/2/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

extension CGRect {
    
    static public func frameWith(center point: CGPoint, size: CGSize) -> CGRect {
        return CGRect(x: point.x - size.width / 2.0, y: point.y - size.height / 2.0, width: size.width, height: size.height)
    }
    
    static public func centerPoint(of frame: CGRect) -> CGPoint {
        return CGPoint(x: frame.midX, y: frame.midY)
    }
    
    static public func frame(center: CGPoint, size: CGSize) -> CGRect {
        return CGRect(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0, width: size.width, height: size.height)
    }
    
    static public func biggerFrame(of frame: CGRect, coefficient: CGFloat) -> CGRect {
        let width = coefficient * frame.width
        let height = coefficient * frame.height
        
        return CGRect(x: frame.midX - width / 2.0, y: frame.midY - height / 2.0, width: width, height: height)
    }
}

