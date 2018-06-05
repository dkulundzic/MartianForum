//
//  UIView-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

public extension UIView {
	public struct AnimationKey {
		static let rotation = "rotationAnimationKey"
        static let shadowOpacity = "shadowOpacityKey"
	}
}

public extension UIView {
  func dropShadow(path: UIBezierPath, color: UIColor = .lightGray, radius: CGFloat = 2, opacity: Float = 0.45, offset: CGSize = CGSize(width: 0, height: 0.8)) {
    layer.shadowPath = path.cgPath
    layer.shadowColor = color.cgColor
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
  }
  
	func dropShadow(shadowColor: UIColor = UIColor.lightGray, radius: CGFloat = 2, opacity: Float = 0.45, offset: CGSize = CGSize(width: 0, height: 0.8)) {
		layer.shadowColor = shadowColor.cgColor
		layer.shadowOffset = offset
		layer.shadowOpacity = opacity
		layer.shadowRadius = radius
	}
	
	func applyBorder(color: UIColor, width: CGFloat) {
		layer.borderColor = color.cgColor
		layer.borderWidth = width
	}
	
	func autolayoutView() -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		return self
	}
	
	class func autolayoutView() -> Self {
		let instance = self.init()
		instance.translatesAutoresizingMaskIntoConstraints = false
		return instance
	}
}

public extension UIView {
	func rotate() {
		if layer.animation(forKey: UIView.AnimationKey.rotation) == nil {
			let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
			rotationAnimation.fromValue = 0.0
			rotationAnimation.toValue = Float.pi * 2.0
			rotationAnimation.duration = 1.25
			rotationAnimation.repeatCount = Float.infinity
			layer.add(rotationAnimation, forKey: UIView.AnimationKey.rotation)
		}
	}
	
	func stopRotating() {
		if layer.animation(forKey: UIView.AnimationKey.rotation) != nil {
			layer.removeAnimation(forKey: UIView.AnimationKey.rotation)
		}
	}
}
