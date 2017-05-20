//
//  UIImage+Gradient.swift
//  NPGradientImageExample
//
//  Created by Nestor Popko on 3/7/16.
//  Copyright © 2016 Nestor Popko. All rights reserved.
//
import UIKit

extension UIImage {
    /**
     Create gradient image from beginColor on top and end color at bottom
     
     - parameter beginColor: beginColor
     - parameter endColor:   endColor
     - parameter frame:      frame to be filled
     
     - returns: filled image
     */
    static func imageWithGradient(from beginColor: UIColor, to endColor: UIColor, with frame: CGRect) -> UIImage {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [beginColor.cgColor, endColor.cgColor]
        layer.startPoint = CGPoint(x: 0, y:0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height))
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func imageWithRainbowGradient(frame: CGRect) -> UIImage {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [UIColor.white.cgColor, UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.black.cgColor]
        layer.startPoint = CGPoint(x: 0, y:0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height))
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func imageWithTransparentLayer(frame: CGRect) -> UIImage {
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.fillColor = UIColor.clear.cgColor
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height))
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
