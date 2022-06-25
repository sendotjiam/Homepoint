//
//  UIView+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit
import SkeletonView

extension UIView {
    func dropShadow(
        with opacity: Float,
        radius: CGFloat,
        offset: CGSize = .zero
    ) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func addBorder(width : CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundedCorner(with radius : CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func addGradientOverlay() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
            UIColor(red: 0.933, green: 0.9, blue: 0.9, alpha: 0).cgColor,
            UIColor(red: 0.25, green: 0.241, blue: 0.241, alpha: 0.72).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.61).cgColor
        ]
        
        gradientLayer.locations = [0.05, 0.18, 0.73, 0.93]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        gradientLayer.position = self.center
        self.layer.insertSublayer(gradientLayer, at: 1)
        
        return gradientLayer
    }
    
    func showShimmer() {
        self.showAnimatedSkeleton()
    }
    
    func stopShimmer() {
        DispatchQueue.main.async {
            self.stopSkeletonAnimation()
            self.hideSkeleton()
        }
    }
    
    func fadeTo(
        _ alpha: CGFloat,
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0,
        completion: (() -> Void)? = nil) {
            
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: .curveEaseInOut,
                animations: {
                    self.alpha = alpha
                },
                completion: nil
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                completion?()
            }
        }
    
    func fadeIn(duration: TimeInterval = 0.3, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(1, duration: duration, delay: delay, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.3, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(0, duration: duration, delay: delay, completion: completion)
    }
}
