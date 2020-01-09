//
//  NSObjectExtensions.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension NSObject {
    func delay(duration: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func hapticFeedBack(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}
