//
//  Product.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/3/31.
//  Copyright © 2020 Harlan. All rights reserved.
//

import Foundation

class Product {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}
