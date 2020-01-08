//
//  ProductTableViewCell.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ProductTableViewCell: BaseTableViewCell<ProductObject> {
    
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
        temp.numberOfLines = 2
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
    
    override func configure(_ product: ProductObject) {
        thumbnailImageView.loadAsync(product.thumbnail)
        nameLabel.text = product.name
        priceLabel.text = product.price.toCurrency()
    }
    
    func configure(_ product: Product) {
        thumbnailImageView.loadAsync(product.thumbnail)
        nameLabel.text = product.name
        priceLabel.text = product.price.toCurrency()
    }
    
}
