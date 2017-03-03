//
//  ViewController.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var colorPicker: ColorPicker? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func updateView() {
        
        let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        colorPicker = ColorPicker(frame: frame)
        if colorPicker != nil {
            colorPicker?.backgroundColor = UIColor.gray
            colorPicker?.innerMargin = 0
            colorPicker?.margin = 3
            colorPicker?.update()
            for item in (colorPicker?.components)! {
                item.layer.cornerRadius = item.frame.width / 2.0
            }
        }
        view.addSubview(colorPicker!)
    }
    
}

