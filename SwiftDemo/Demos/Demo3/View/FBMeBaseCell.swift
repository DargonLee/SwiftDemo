//
//  FBMeBaseCell.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/27.
//  Copyright © 2020 Harlan. All rights reserved.
//

import UIKit

class FBMeBaseCell: UITableViewCell {
    
    static let identifier: String = "FBMeBaseCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.textColor = Specs.color.gray
        detailTextLabel?.font = Specs.font.small
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


