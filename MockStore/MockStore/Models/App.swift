//
//  App.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import Foundation

struct App: Decodable, Hashable {
	let id: Int
	let tagline: String
	let name: String
	let subheading: String
	let image: String
	let iap: Bool // in-app purchase
}
