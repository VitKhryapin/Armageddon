//
//  CustomButton.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 30.04.2022.
//


import UIKit

class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            guard let color = backgroundColor else { return }
            layer.removeAllAnimations()
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.backgroundColor = color.withAlphaComponent(self.isHighlighted ? 0.3 : 1)
            })
        }
    }
}
