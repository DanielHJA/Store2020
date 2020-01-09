//
//  CategoriesTableViewCell.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-09.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.textAlignment = .left
        temp.minimumScaleFactor = 0.7
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    func configure(_ string: String) {
        label.text = string
    }
    
}
