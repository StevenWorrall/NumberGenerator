//
//  Helpers.swift
//  Random_Number
//
//  Created by Steven Worrall on 8/19/21.
//

import Foundation
import UIKit

enum FontWeight {
    case regular
    case semiBold
    case bold
}

class Label: UILabel {
    
    init(
        title: String,
        fontSize: CGFloat = 16,
        weight: FontWeight = .regular
    ) {
        super.init(frame: .zero)
        
        self.text = title
        self.textColor = .black
        
        var fontWeight: String
        switch weight {
        case .regular:
            fontWeight = "HelveticaNeue"
        case .semiBold:
            fontWeight = "HelveticaNeue-Medium"
        case .bold:
            fontWeight = "HelveticaNeue-Bold"
        }
        
        self.font = UIFont(name: fontWeight, size: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Button: UIButton {
    private weak var shade: CALayer?
    private let screenWidth = UIScreen.main.bounds.width
    private lazy var width = self.screenWidth * 0.48
    private lazy var height = self.width * 0.23
    private let fontSize: CGFloat = 16

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: fontSize)
        self.backgroundColor = color
        self.layer.cornerRadius = height / 2
        self.layer.masksToBounds = true
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shade = self.shade {
            shade.frame = bounds
            shade.cornerRadius = layer.cornerRadius
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let shade = createShade()
        layer.addSublayer(shade)
        self.shade = shade
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shade?.removeFromSuperlayer()
        super.touchesEnded(touches, with: event)
    }
    
    private func createShade() -> CALayer {
        let shadeLayer = CALayer()
        shadeLayer.frame = bounds
        shadeLayer.opacity = 0.05
        shadeLayer.backgroundColor = UIColor.black.cgColor
        return shadeLayer
    }
}

extension UIViewController {
    func presentAlert(
        title: String,
        message: String,
        completion: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Okay",
                style: .default,
                handler: completion)
        )
        
        present(alert, animated: true, completion: nil)
    }
}
