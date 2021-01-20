//
//  Bundle+extensions.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import Foundation

// method to help decode any type from any file in Bundle

extension Bundle {
	func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Could not find \(file) in bundle!")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Could not load \(file) from bundle!")
		}
		
		let decoder = JSONDecoder()
		
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Could not decode \(file) from bundle!")
		}
		
		return loaded
	}
}
