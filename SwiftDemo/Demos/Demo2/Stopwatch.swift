//
//  Stopwatch.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/13.
//  Copyright © 2020 Harlan. All rights reserved.
//

import Foundation


class Stopwatch: NSObject {
    
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
    
}
