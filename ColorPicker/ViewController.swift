//
//  ViewController.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

let colorPickerComponentZoomCoefficient: CGFloat = 1.5

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var colorPicker: UIView!
    
    private var components = [UIView]()
    
    private var colorPickerComponentSize: CGSize {
        get {
            return CGSize(width: 10, height: 10)
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupComponents()
    }
    
    // MARK: - Methods
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let radius: CGFloat = 30
        for item in touches {
            let point = item.location(in: view)
            let touchFrame = CGRect.frame(center: point, size: CGSize(width: radius, height: radius))
            for item in view.subviews {
                if item.frame.width > colorPickerComponentSize.width || item.frame.height > colorPickerComponentSize.height {
                    continue
                }
                if touchFrame.intersects(item.frame) {
                    let oldFrame = item.frame
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                        item.frame = CGRect.biggerFrame(of: item.frame, coefficient: colorPickerComponentZoomCoefficient)
                    }, completion: { finished in
                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                            item.frame = oldFrame
                        }, completion: nil)
                    })
                }
            }
        }
    }
    
    private func setupComponents() {        
        let innerMargin: CGFloat = 5
        let margin: CGFloat = 2
        let rows = 20
        let cols = 20
        for row in 0..<rows {
            for col in 0..<cols {
                // random color
                let color = UIColor.randomColor()
                // component origin
                let x = colorPicker.frame.minX + innerMargin + (margin + colorPickerComponentSize.width) * CGFloat(col)
                let y = colorPicker.frame.minY + innerMargin + (margin + colorPickerComponentSize.height) * CGFloat(row)
                // component
                let component = UIView(frame: CGRect(x: x, y: y, width: colorPickerComponentSize.width, height: colorPickerComponentSize.height))
                component.backgroundColor = color
                component.tag = row * cols + col
                components.append(component)
                view.addSubview(component)
            }
        }
    }
    
}

extension UIView {
    
    static func colorPicker(frame: CGRect) -> UIView {
        let picker = UIView(frame: frame)
        picker.backgroundColor = UIColor.white // or UIColor.black
        let rows = 8
        let cols = 8
        let size = CGSize(width: frame.width / CGFloat(rows), height: frame.height / CGFloat(cols))
        for row in 0..<rows {
            for col in 0..<cols {
                let index = col + row * cols
                
                let component = UIView()
                component.tag = index
                component.frame = CGRect(x: CGFloat(col) * size.width, y: CGFloat(row) * size.height, width: size.width, height: size.height)
                
                component.backgroundColor = UIColor.randomColor()
                
                picker.addSubview(component)
            }
        }
        return picker
    }
}





