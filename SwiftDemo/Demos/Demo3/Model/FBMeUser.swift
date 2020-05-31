//
//  FBMeUser.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/23.
//  Copyright © 2020 Harlan. All rights reserved.
//

import Foundation

class FBMeUser {
    var name: String
    var avatarName: String
    var education: String
    
    init(name: String, avatarName: String = "bayMax", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
