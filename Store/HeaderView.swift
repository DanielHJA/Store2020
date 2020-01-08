//
//  HeaderView.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    private lazy var content: UIView = {
        let temp = UIView()
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        return temp
    }()

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.textAlignment = .left
        temp.minimumScaleFactor = 0.7
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 19.0, weight: .medium)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: content.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -5.0).isActive = true
        return temp
    }()
    
    private lazy var separator: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.blue
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: content.leadingAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFrames()
    }
    
    private func configureFrames() {}
    
    private func commonInit() {
        backgroundColor = .white
        separator.isHidden = false
    }
    
    convenience init(title: String) {
        self.init()
        label.text = title
    }

}
