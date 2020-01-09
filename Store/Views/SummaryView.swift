//
//  SummaryView.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol PaymentDelegate: class {
    func didTapBuyButton()
}

class SummaryView: UIView {
    
    weak var delegate: PaymentDelegate?
    
    var price: Double = 0 {
        didSet {
            label.text = "Total att betala: \(price.toCurrency())"
        }
    }
    
    var buttonIsEnabled: Bool = false {
        didSet {
            if buttonIsEnabled {
                button.isEnabled = true
                button.backgroundColor =  UIColor(red: 0.000, green: 0.572, blue: 0.000, alpha: 1.00)
            } else {
                button.isEnabled = false
                button.backgroundColor =  .lightGray
            }
        }
    }
    
    private lazy var content: UIView = {
        let temp = UIView()
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0).isActive = true
        return temp
    }()
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.white
        temp.textAlignment = .left
        temp.minimumScaleFactor = 0.7
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        content.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: content.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8.0).isActive = true
        temp.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var button: UIButton = {
        let temp = UIButton()
        temp.setTitle("Betala", for: .normal)
        temp.layer.cornerRadius = 5.0
        temp.setTitleColor(UIColor.white, for: .normal)
        temp.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        temp.backgroundColor = UIColor(red: 0.000, green: 0.572, blue: 0.000, alpha: 1.00)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35).isActive = true
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
        label.isHidden = false
        button.isHidden = false
        backgroundColor = UIColor.black
    }
    
    @objc private func didTapBuyButton() {
        delegate?.didTapBuyButton()
    }

}
