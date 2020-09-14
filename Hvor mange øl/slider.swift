//
//  slider.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 01.11.2018.
//  Copyright © 2018 øl. All rights reserved.
//

import UIKit
let THUMB_SIZE = 10
let EFFECTIVE_THUMB_SIZE = 20
@IBDesignable
class slider: UISlider {
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(self.generateHandleImage(with: .white), for: .normal)
        }
    }
    private func generateHandleImage(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.bounds.size.height + 20, height: self.bounds.size.height + 20)
        
        return UIGraphicsImageRenderer(size: rect.size).image { (imageContext) in
            imageContext.cgContext.setFillColor(color.cgColor)
            imageContext.cgContext.fill(rect.insetBy(dx: 20, dy: 20))
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
