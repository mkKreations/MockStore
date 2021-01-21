//
//  UIButton+extensions.swift
//  MockStore
//
//  Created by Marcus on 1/20/21.
//

import UIKit

extension UIButton {
	// allow us to set background color for state on buttonsg
	func setBackgroundColor(_ color: UIColor, forState state: UIControl.State) {
		self.clipsToBounds = true  // this maintains corner radius
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		if let context = UIGraphicsGetCurrentContext() {
			context.setFillColor(color.cgColor)
			context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
			let colorImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			self.setBackgroundImage(colorImage, for: state)
		}
	}
}
