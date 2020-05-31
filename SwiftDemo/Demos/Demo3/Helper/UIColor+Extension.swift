//
//  UIColor+Extension.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/23.
//  Copyright © 2020 Harlan. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    convenience init(hex: Int) {
        self.init(r: CGFloat((hex & 0xff0000) >> 16), g: CGFloat((hex & 0xff00) >> 8), b: (CGFloat(hex & 0xff)), a: 1)
    }
}

