//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/3/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func didPick(_ color: UIColor)
}

class ColorPicker: UIView {
    
    // MARK: - Properties
    
    // public
    
    public var delegate: ColorPickerDelegate?
    
    public var componentZoomCoefficient: CGFloat = 1.5
    
    public var innerMargin: CGFloat = 5
    
    public var margin: CGFloat = 2
    
    public var components = [UIView]()
    
    public var colors = defaultColors // Array<Array<UIColor>>
    
    // private
    
    private var componentFrames = [CGRect]()
    
    private var lastPickedColor: UIColor?
    
    // MARK: - Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }
    
    // MARK: - Methods
    
    public func update() {
        removeComponents()
        // setup new components
        for row in 0..<colors.count {
            for col in 0..<colors[row].count {
                let color = colors[row][col]
                // component size
                let w = (frame.width - 2 * innerMargin - CGFloat(colors[row].count - 1) * margin) / CGFloat(colors[row].count)
                let h = (frame.height - 2 * innerMargin - CGFloat(colors.count - 1) * margin) / CGFloat(colors.count)
                let colorPickerComponentSize = CGSize(width: w, height: h)
                // component origin
                let x = innerMargin + (margin + colorPickerComponentSize.width) * CGFloat(col)
                let y = innerMargin + (margin + colorPickerComponentSize.height) * CGFloat(row)
                // component
                let component = UIView(frame: CGRect(x: x, y: y, width: colorPickerComponentSize.width, height: colorPickerComponentSize.height))
                component.backgroundColor = color
                component.tag = row * colors[row].count + col
                components.append(component)
                componentFrames.append(component.frame)
                addSubview(component)
            }
        }
    }
    
    private func removeComponents() {
        for item in subviews {
            item.removeFromSuperview()
        }
        components = []
        componentFrames = []
    }
    
    // MARK: - Override Touches Methods
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let radius: CGFloat = 30
        for touch in touches {
            let tap = touch.location(in: self)
            let touchFrame = CGRect.frame(center: tap, size: CGSize(width: radius, height: radius))
            for index in 0..<components.count {
                let component = components[index]
                if component.frame.width > componentFrames[index].width || component.frame.height > componentFrames[index].height {
                    continue
                }
                if touchFrame.intersects(component.frame) {
                    lastPickedColor = component.backgroundColor                    
                    let oldFrame = componentFrames[index]
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                        component.frame = CGRect.biggerFrame(of: component.frame, coefficient: self.componentZoomCoefficient)
                    }, completion: { finished in
                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                            component.frame = oldFrame
                        }, completion: nil)
                    })
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if lastPickedColor != nil {
            delegate?.didPick(lastPickedColor!)
        }
        if touches.count > 0 {
            if let tap = touches.first?.location(in: self) {
                for index in 0..<components.count {
                    let item = components[index]
                    let newFrame = CGRect(x: tap.x - item.frame.width / 2.0, y: tap.y - item.frame.height / 2.0, width: item.frame.width, height: item.frame.height)
                    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                        item.frame = newFrame
                    }, completion: { finished in
                        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                            item.frame = self.componentFrames[index]
                        }, completion: nil)
                    })
                }
            }
        }
    }
}
