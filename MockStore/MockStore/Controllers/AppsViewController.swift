//
//  AppsViewController.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import UIKit

class AppsViewController: UIViewController {
	// MARK: internal properties
	private lazy var collectionView: UICollectionView = {
		UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
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
	
	private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
			let currentSection = self.sections[sectionIndex]
			
			switch currentSection {
			default:
				return self.createFeaturedSection(using: currentSection)
			}
		}

		// assign section spacing using layout config
		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = 20.0
		layout.configuration = config
		return layout
	}
	
	private func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),
																					 heightDimension: .estimated(350.0))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPagingCentered
		
		return section
	}
	
}
