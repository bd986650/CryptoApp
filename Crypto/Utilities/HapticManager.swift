//
//  HapticManager.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import SwiftUI

class HapticManager {
    static private let notificationGenerator = UINotificationFeedbackGenerator()
    
    static func playNotificationHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(type)
    }
    
    static func playImpactHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactGenerator = UIImpactFeedbackGenerator(style: style)
        impactGenerator.impactOccurred()
    }
}
