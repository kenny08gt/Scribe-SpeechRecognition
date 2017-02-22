//
//  CirlceButton.swift
//  Scribe
//
//  Created by LionMane Software on 2/22/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit

@IBDesignable

class CirlceButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet{
            setupView()
        }
    }

    override func prepareForInterfaceBuilder() {
        setupView()
        
    }
    
    func setupView(){
        layer.cornerRadius = cornerRadius
    }
}
