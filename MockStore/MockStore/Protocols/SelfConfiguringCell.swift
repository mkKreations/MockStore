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
}
