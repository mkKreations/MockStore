//
//  FeaturedCell.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = String(describing: self)
	func configure(with app: App) {
		taglineLabel.text = app.tagline.uppercased()
		nameLabel.text = app.name
		subtitleLabel.text = app.subheading
		featuredImageView.image = UIImage(named: app.image)
	}
	
	
	// MARK: internal properties
	private let separator: UIView = UIView(frame: .zero)
	private let taglineLabel: UILabel = UILabel(frame: .zero)
	private let nameLabel: UILabel = UILabel(frame: .zero)
	private let subtitleLabel: UILabel = UILabel(frame: .zero)
	private let featuredImageView: UIImageView = UIImageView(frame: .zero)
	private let vertStackView: UIStackView = UIStackView()
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureSubviews()
		autoLayoutSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in FeaturedCell")
	}
	
	
	// MARK: helpers
	private func configureSubviews() {
		separator.backgroundColor = .quaternaryLabel
		
		// UIFontMetrics.default.scaledFont supports dynamic type
		taglineLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
		taglineLabel.textColor = .systemBlue
		
		nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
		nameLabel.textColor = .label

		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
		subtitleLabel.textColor = .secondaryLabel

		featuredImageView.layer.cornerRadius = 5.0
		featuredImageView.clipsToBounds = true
		featuredImageView.contentMode = .scaleAspectFit
		
		vertStackView.translatesAutoresizingMaskIntoConstraints = false
		vertStackView.axis = .vertical
		vertStackView.setCustomSpacing(10.0, after: separator) // custom spacing to match layout
		vertStackView.setCustomSpacing(10.0, after: subtitleLabel) // custom spacing to match layout
		[separator, taglineLabel, nameLabel, subtitleLabel, featuredImageView].forEach { vertStackView.addArrangedSubview($0) }
		contentView.addSubview(vertStackView)
	}
	private func autoLayoutSubviews() {
		separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
		vertStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		vertStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		vertStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		vertStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
	}
}
