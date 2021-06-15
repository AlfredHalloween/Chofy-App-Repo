//
//  LottiesAnimation.swift
//  ChofyStyleGuide
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation
import Lottie

public struct ChofyAnim {
    public static var search: AnimationView {
        let animationView = AnimationView()
        let anim = Animation.named("49993-search", bundle: ChofyStyleBundle.bundle)
        animationView.animation = anim
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return animationView
    }
}
