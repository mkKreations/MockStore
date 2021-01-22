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
		// lazy so I can call methods within and don't have to use forced unwrapped options
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
		
		// collectionView background adapts to light/dark mode
		collectionView.backgroundColor = .systemBackground
		
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
		collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
		collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)
		collectionView.register(SectionHeader.self,
														forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
														withReuseIdentifier: SectionHeader.reuseIdentifier)
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
			// extract current section
			let currentSection = self.sections[indexPath.section]
			
			// switch on Section.type
			switch currentSection.type {
			case "smallTable":
				// only show separator if isn't the last cell
				let cell = self.configure(SmallTableCell.self, with: app, for: indexPath)
				cell.showsSeparator(shows: currentSection.items.count != (indexPath.row + 1))
				return cell
			case "mediumTable":
				// only show separator if the cell indexPath.row + 1 is not divisible by 3
				let cell = self.configure(MediumTableCell.self, with: app, for: indexPath)
				cell.showsSeparator(shows: (indexPath.row + 1) % 3 != 0)
				return cell
			default:
				return self.configure(FeaturedCell.self, with: app, for: indexPath)
			}
		})
		
		datasource.supplementaryViewProvider = { (view, kind, indexPath) -> UICollectionReusableView? in
			// extract current section
			let currentSection = self.sections[indexPath.section]
			print("HEADER CURRENT SECTION!!!!")

			if kind == UICollectionView.elementKindSectionHeader && !currentSection.title.isEmpty {
				guard let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind,
																																								withReuseIdentifier: SectionHeader.reuseIdentifier,
																																								for: indexPath) as? SectionHeader else {
					fatalError("Failed to dequeue SectionHeader")
				}
				print("DEQUEUEING HEADER!!!!")
				header.nameText = currentSection.title
				header.subtitleText = currentSection.subtitle
				return header
			}
			return nil
		}
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
			// extract current section
			let currentSection = self.sections[sectionIndex]
			
			// switch on Section.type
			switch currentSection.type {
			case "smallTable":
				return self.createSmallTableSection(using: currentSection)
			case "mediumTable":
				return self.createMediumTableSection(using: currentSection)
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
		
		let layoutSection = NSCollectionLayoutSection(group: group)
		layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
//		createSectionHeaderLayout(forSection: layoutSection)

		return layoutSection
	}
	
	private func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(0.33))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),
																					 heightDimension: .estimated(180.0))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
																								 subitem: item,
																								 count: 3)
		
		let layoutSection = NSCollectionLayoutSection(group: group)
		layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
		createSectionHeaderLayout(forSection: layoutSection)

		return layoutSection
	}
	
	private func createSmallTableSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(0.20))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 24.0, bottom: 0.0, trailing: 24.0)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					 heightDimension: .estimated(240.0))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
																								 subitem: item,
																								 count: 5)
		
		let layoutSection = NSCollectionLayoutSection(group: group)
		createSectionHeaderLayout(forSection: layoutSection)

		return layoutSection
	}
	
	private func createSectionHeaderLayout(forSection section: NSCollectionLayoutSection) {
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																						heightDimension: .estimated(70.0))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
																																		elementKind: UICollectionView.elementKindSectionHeader,
																																		alignment: .topLeading)
		section.boundarySupplementaryItems = [sectionHeader]
	}
	
}
