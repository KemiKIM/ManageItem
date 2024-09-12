//
//  LottieManager.swift
//  ManageItem
//
//  Created by 김성호 on 9/3/24.
//

import UIKit
import SnapKit
import Lottie

class LottieManager {

    static let shared = LottieManager()

    private init() {}

    // Lottie 애니메이션 뷰 생성
    func createLottieAnimationView(name: String, frame: CGRect, loopMode: LottieLoopMode = .loop, speed: CGFloat = 1.0) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.backgroundColor = .white
        animationView.frame = frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        return animationView
    }

    func startAnimation(view: UIView, animationView: LottieAnimationView?, errorCompletion: @escaping () -> Void) {
        guard let animationView = animationView else {
            errorCompletion()
            return
        }
        
        let backView = UIView()
        backView.backgroundColor = .white
        
        view.addSubview(backView)
        view.sendSubviewToBack(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        animationView.center = view.center
        view.addSubview(animationView)
        view.bringSubviewToFront(animationView)
        
        animationView.play()
    }

    func stopAnimation(animationView: LottieAnimationView) {
        animationView.stop()
        animationView.removeFromSuperview()
    }
}

