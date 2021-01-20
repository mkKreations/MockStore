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
	
	
	// MARK: internal properties
	private lazy var collectionView: UICollectionView = {
		UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	}()
	
	
	// MARK: view life cycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// nav bar setup
		title = "Apps"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.isTranslucent = false
		
		// view background
		view.backgroundColor = .black
		
		// collectionView config
		configureCollectionView()
		
		// TODO: will be removed when we add cells
		navBarDividerSetUp()
	}
	
	
	// MARK: helpers
	private func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		
		layoutCollectionView()
	}
	
	private func layoutCollectionView() {
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
