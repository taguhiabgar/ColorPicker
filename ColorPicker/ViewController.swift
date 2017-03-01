//
//  ViewController.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var views = [UIView]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func setupViews() {
        // draw views
        for _ in 0..<10 {
            addRandomView()
        }
        // add a transparent view
        addTopmostTransparentView()
    }
    
    private func addRandomView() {
        let newView = UIView()
        newView.backgroundColor = UIColor.randomColor()
        let size = view.frame.size
        let x = CGFloat(arc4random() % UInt32(size.width / 2.0))
        let y = CGFloat(arc4random() % UInt32(size.height / 2.0))
        let side = size.width / 6.0
        newView.frame = CGRect(x: x, y: y, width: side, height: side)
        views.append(newView) // to keep reference
        view.addSubview(newView)
    }
    
    private func addTopmostTransparentView() { // to recognize long press
        let transparentView = UIView(frame: view.frame)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(sender:)))
        transparentView.addGestureRecognizer(gesture)
        self.view.addSubview(transparentView)
    }
    
    @objc private func longPressAction(sender: UILongPressGestureRecognizer) {
        let tap = sender.location(in: sender.view)
        
        for item in views {
            let oldFrame = item.frame
//            let newFrame = CGRect(x: view.frame.width - item.frame.width, y: view.frame.height - item.frame.height, width: item.frame.width, height: item.frame.height)
            let newFrame = CGRect(x: tap.x - item.frame.width / 2.0, y: tap.y - item.frame.height / 2.0, width: item.frame.width, height: item.frame.height)
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                item.frame = newFrame
            }, completion: { finished in
                UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                    item.frame = oldFrame
                }, completion: nil)
            })
        }
        
        
        
        print("x: \(tap.x), y: \(tap.y)")
    }
    
}

extension UIColor {
    
    static func randomColor() -> UIColor {
        return UIColor(red: randomColorValue(), green: randomColorValue(), blue: randomColorValue(), alpha: randomColorValue())
    }
    
    static private func randomColorValue() -> CGFloat {
        let number = arc4random() % 255
        return CGFloat(number) / 255.0
    }
}
