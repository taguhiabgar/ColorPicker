//
//  ViewController.swift
//  ColorPicker
//
//  Created by Taguhi Abgaryan on 3/1/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorPickerDelegate {
    
    var colorPicker: ColorPicker? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func updateView() {
        let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        colorPicker = ColorPicker(frame: frame)
        if colorPicker != nil {
            colorPicker?.delegate = self
            colorPicker?.backgroundColor = UIColor.black
            colorPicker?.innerMargin = 3
            colorPicker?.margin = 3
            colorPicker?.update()
        }
        view.addSubview(colorPicker!)
    }
    
    func didPick(_ color: UIColor) {
        view.backgroundColor = color
    }
    
}

