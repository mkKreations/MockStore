//
//  Section.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import Foundation

struct Section: Decodable, Hashable {
	let id: Int
	let type: String
	let title: String
	let subtitle: String
	let items: [App]
}
