//
//  Extensions.swift
//  SampleDemo
//
//  Created by wuqh on 2019/10/29.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

extension UIImageView {
    func cornerRadiusOptimized(radius: CGFloat) {
        self.image = self.image?.drawRectWithRoundedCorner(radius: radius, self.bounds.size)
    }
}

extension UIImage {
    fileprivate func drawRectWithRoundedCorner(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        context?.clip()
        
        self.draw(in: rect)
        context?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return output
    }
}

extension UIColor {
    static var random: UIColor {
        let r:CGFloat  = .random(in: 0...1)
        let g:CGFloat  = .random(in: 0...1)
        let b:CGFloat  = .random(in: 0...1)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
