//
//  AppsViewController.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import UIKit

class AppsViewController: UIViewController {
	// TODO: will be removed when we add cells
	private let navBarDivider: UIView = UIView(frame: .zero)
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// nav bar setup
		title = "Apps"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.isTranslucent = false
		
		// view background
		view.backgroundColor = .black
		
		// TODO: will be removed when we add cells
		navBarDividerSetUp()
	}
	
	// TODO: will be removed when we add cells
	private func navBarDividerSetUp() {
		navBarDivider.translatesAutoresizingMaskIntoConstraints = false
		navBarDivider.backgroundColor = .darkGray
		view.addSubview(navBarDivider)
		
		navBarDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0).isActive = true
		navBarDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0).isActive = true
		navBarDivider.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		navBarDivider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
	}
	
}
