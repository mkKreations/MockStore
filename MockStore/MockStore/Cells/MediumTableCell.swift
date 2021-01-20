//
//  MediumTableCell.swift
//  MockStore
//
//  Created by Marcus on 1/20/21.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = String(describing: self)
	func configure(with app: App) {
		// TODO: implement
	}
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in MediumTableCell")
	}
}
