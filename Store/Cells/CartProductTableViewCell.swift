//
//  wqe.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-10.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol CartProductTableViewCellDelegate: class {
    func removeProductAtIndexPath(_ indexPath: IndexPath)
    func cartChanged()
}

class CartProductTableViewCell: BaseTableViewCell<Product> {
    
    weak var delegate: CartProductTableViewCellDelegate?
    var indexPath: IndexPath?
    
    var product: Product! {
        didSet {
            thumbnailImageView.loadAsync(product.thumbnail)
            nameLabel.text = product.name
            priceLabel.text = product.price.toCurrency()
            stepper.value = Double(product.count)
            changeStepperValue()
        }
    }
    
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
    
    private lazy var thumbnailImageView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        content.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5.0).isActive = true
        temp.centerYAnchor.constraint(equalTo: content.centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: content.heightAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: temp.heightAnchor).isActive = true
        return temp
    }()
    
    private lazy var nameLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.textAlignment = .left
        temp.minimumScaleFactor = 0.7
        temp.numberOfLines = 3
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        return temp
    }()
    
    private lazy var priceLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.darkGray
        temp.textAlignment = .left
        temp.minimumScaleFactor = 0.7
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        return temp
    }()
    
    private lazy var stepper: UIStepper = {
        let temp = UIStepper()
        temp.minimumValue = 0
        temp.stepValue = 1.0
        temp.addTarget(self, action: #selector(changeStepperValue), for: .valueChanged)
        temp.tintColor = UIColor.blue
        temp.backgroundColor = UIColor.clear
        content.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var stepperLabel: UILabel = {
        let temp = UILabel()
        temp.text = "0"
        temp.textColor = UIColor.black
        temp.textAlignment = .center
        temp.minimumScaleFactor = 0.7
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        content.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        return temp
    }()
    
    @objc private func changeStepperValue() {
        let value = stepper.value
        
        if value == 0 {
            if let indexPath = indexPath {
                delegate?.removeProductAtIndexPath(indexPath)
            }
        } else {
            stepperLabel.text = "\(Int(value))"
            product.setCount(Int(value))
            delegate?.cartChanged()
        }
    }

}
