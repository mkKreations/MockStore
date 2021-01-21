//
//  SelfConfiguringCell.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import Foundation

// this protocol allows us to create a cell
// with any type of layout, but as long as it
// conforms to this protocol, we can dequeue it
// for reuse with diffable datasource

protocol SelfConfiguringCell {
	static var reuseIdentifier: String { get }
	func configure(with app: App)
	func showsSeparator(shows: Bool) // has default implementation below
}

// MARK: default implementation for any "specific" cases

// in this case we only want one type of cell that
// conforms to SelfConfiguringCell to display a
// separator - not every type that will conform. As
// such, providing a default implementation ensures
// that we only have to define this method in the
// desired type that conforms to SelfConfiguringCell,
// not each and every type that conforms
extension SelfConfiguringCell {
	func showsSeparator(shows: Bool) {} // only applies to MediumTableCell
}
