//
//  GradientView.swift
//  Armageddon2022
//
//  Created by Vitaly Khryapin on 25.04.2022.
//

import Foundation
import UIKit

class GradientView: UIView {
    var mainPresentor: MainPresenter!
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        return gradientLayer
    }()
    
    func updateGradient() {
        if gradientLayer.superlayer == nil {
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.frame = self.bounds
    }
}
