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
	private var datasource: UICollectionViewDiffableDataSource<Section, App>!
	private let sections: [Section] = Bundle.main.decode([Section].self, from: "appstore.json")
	
	
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
		configureDatasource()
		
		// apply initial snapshot
		applySnapshot()
		
		// TODO: will be removed when we add cells
		navBarDividerSetUp()
	}
	
	
	// MARK: helpers
	private func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
		view.addSubview(collectionView)
		
		layoutCollectionView()
	}
	
	private func layoutCollectionView() {
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
	
	private func configureDatasource() {
		datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, app) -> UICollectionViewCell? in
			switch self.sections[indexPath.section].type {
			default:
				return self.configure(FeaturedCell.self, with: app, for: indexPath)
			}
		})
	}
	
	private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Unable to dequeue \(cellType)")
		}
		cell.configure(with: app)
		return cell
	}
	
	private func applySnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
		snapshot.appendSections(sections) // append sections
		sections.forEach { snapshot.appendItems($0.items, toSection: $0) } // appends items to section
		datasource.apply(snapshot)
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
