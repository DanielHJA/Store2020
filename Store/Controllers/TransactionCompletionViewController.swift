//
//  TransactionCompletionViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-09.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class TransactionCompletionViewController: UIViewController {

    private lazy var barButtonItem: UIBarButtonItem = {
        let temp = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(close))
        temp.tintColor = .black
        return temp
    }()
    
    private lazy var lottieAnimationView: LottieAnimationView = {
        let temp = LottieAnimationView(name: "TransactionCompleted")
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        temp.heightAnchor.constraint(equalTo: temp.widthAnchor, multiplier: 1.2).isActive = true
        return temp
    }()
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.text = "Din beställning är på väg!"
        temp.textColor = UIColor.darkGray
        temp.textAlignment = .center
        temp.minimumScaleFactor = 0.7
        temp.adjustsFontSizeToFitWidth = true
        temp.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: lottieAnimationView.bottomAnchor, constant: 10.0).isActive = true
        return temp
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
        lottieAnimationView.isHidden = false
        label.isHidden = false
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}
