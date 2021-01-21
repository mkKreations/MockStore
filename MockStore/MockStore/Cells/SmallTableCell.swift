//
//  SmallTableCell.swift
//  MockStore
//
//  Created by Marcus on 1/21/21.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = UUID().uuidString
	func configure(with app: App) {
		// TODO: implement
	}
	func showsSeparator(shows: Bool) {
		// TODO: implement
	}
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in SmallTableCell")
	}
}
