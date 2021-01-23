//
//  SmallTableCell.swift
//  MockStore
//
//  Created by Marcus on 1/21/21.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = UUID().uuidString
	func configure(with app: App) {
		imageView.image = UIImage(named: app.image)
		nameLabel.text = app.name
	}
	func showsSeparator(shows: Bool) {
		separator.isHidden = !shows
	}
	
	
	// MARK: layout constants
	private static let imageViewSize: CGFloat = 20.0
	private static let horizontalStackViewSpacing: CGFloat = 15.0
	private static let separatorHeight: CGFloat = 1.0
	
	
	// MARK: internal properties
	private let imageView: UIImageView = UIImageView(frame: .zero)
	private let nameLabel: UILabel = UILabel(frame: .zero)
	private let stackView: UIStackView = UIStackView(frame: .zero)
	private let separator: UIView = UIView(frame: .zero)
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureSubviews()
		constrainSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in SmallTableCell")
	}
	
	
	// MARK: helpers
	private func configureSubviews() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 3.0
		
		nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
		nameLabel.textColor = .label
		
		[imageView, nameLabel].forEach { stackView.addArrangedSubview($0) }
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.alignment = .center
		stackView.spacing = Self.horizontalStackViewSpacing
		contentView.addSubview(stackView)
		
		separator.translatesAutoresizingMaskIntoConstraints = false
		separator.backgroundColor = .tertiarySystemFill
		contentView.addSubview(separator)
	}
	private func constrainSubviews() {
		imageView.heightAnchor.constraint(equalToConstant: Self.imageViewSize).isActive = true
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

		stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		
		separator.heightAnchor.constraint(equalToConstant: Self.separatorHeight).isActive = true
		separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.imageViewSize + Self.horizontalStackViewSpacing).isActive = true
		separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
}
