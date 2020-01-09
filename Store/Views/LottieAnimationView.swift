//
//  AnimationView.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-09.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Lottie

class LottieAnimationView: UIView {
    
    private var lottieView: AnimationView!

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
    
    private func configureFrames() { }
    private func commonInit() { }

    init(name: String) {
        self.init()
        lottieView = AnimationView(name: name)
//        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        addSubview(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lottieView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lottieView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lottieView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lottieView.play()
    }
}
