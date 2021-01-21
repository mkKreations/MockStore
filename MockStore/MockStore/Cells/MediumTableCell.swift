//
//  MediumTableCell.swift
//  MockStore
//
//  Created by Marcus on 1/20/21.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = String(describing: self)
	func configure(with app: App) {
		nameLabel.text = app.name
		subtitleLabel.text = app.subheading
		imageView.image = UIImage(named: app.image)
	}
	
	
	// MARK: layout constants
	private static let imageViewSize: CGFloat = 50.0
	private static let horizontalStackViewSpacing: CGFloat = 10.0
	private static let verticalStackViewMargin: CGFloat = 5.0
	private static let buyButtonHeight: CGFloat = 28.0
	private static let buyButtonWidth: CGFloat = 70.0
	private static let separatorHeight: CGFloat = 1.0
	
	
	// MARK: internal properties
	private let nameLabel: UILabel = UILabel(frame: .zero)
	private let subtitleLabel: UILabel = UILabel(frame: .zero)
	private let imageView: UIImageView = UIImageView(frame: .zero)
	private let buyButton: UIButton = UIButton(type: .custom)
	private let labelsStackView: UIStackView = UIStackView(frame: .zero)
	private let imageLabelsButtonStackView: UIStackView = UIStackView(frame: .zero)
	private let separator: UIView = UIView(frame: .zero)
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureSubviews()
		constrainSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in MediumTableCell")
	}
	
	
	// MARK: helpers
	private func configureSubviews() {
		nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		nameLabel.textColor = .label

		// can't decide which font I prefer
//		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
		subtitleLabel.textColor = .secondaryLabel
		subtitleLabel.numberOfLines = 2
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 15.0
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		
		buyButton.translatesAutoresizingMaskIntoConstraints = false
		buyButton.setBackgroundColor(.quaternarySystemFill, forState: .normal)
		buyButton.setBackgroundColor(.secondarySystemFill, forState: .highlighted)
		buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
		buyButton.setTitle("GET", for: .normal)
		buyButton.setTitleColor(.systemBlue, for: .normal)
		buyButton.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.5), for: .highlighted)
		buyButton.layer.cornerRadius = 14.0
		buyButton.addTarget(self, action: #selector(buyButtonPressed), for: .touchUpInside)

		[nameLabel, subtitleLabel].forEach { labelsStackView.addArrangedSubview($0) }
		labelsStackView.distribution = .fill
		labelsStackView.axis = .vertical
		
		imageLabelsButtonStackView.translatesAutoresizingMaskIntoConstraints = false
		[imageView, labelsStackView, buyButton].forEach { imageLabelsButtonStackView.addArrangedSubview($0) }
		imageLabelsButtonStackView.distribution = .fill
		imageLabelsButtonStackView.alignment = .center // essential to centering horizontal content on vertical axis
		imageLabelsButtonStackView.spacing = Self.horizontalStackViewSpacing
		imageLabelsButtonStackView.axis = .horizontal
		contentView.addSubview(imageLabelsButtonStackView)
		
		separator.backgroundColor = .tertiarySystemFill
		separator.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(separator)
	}
	private func constrainSubviews() {
		imageView.heightAnchor.constraint(equalToConstant: Self.imageViewSize).isActive = true
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

		imageLabelsButtonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.verticalStackViewMargin).isActive = true
		imageLabelsButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalStackViewMargin).isActive = true
		imageLabelsButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		imageLabelsButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
				
		buyButton.heightAnchor.constraint(equalToConstant: Self.buyButtonHeight).isActive = true
		buyButton.widthAnchor.constraint(equalToConstant: Self.buyButtonWidth).isActive = true
		
		separator.heightAnchor.constraint(equalToConstant: Self.separatorHeight).isActive = true
		separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.imageViewSize + Self.horizontalStackViewSpacing).isActive = true
		separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
	
	@objc func buyButtonPressed(_ sender: UIButton) {
		print("Buy button pressed!")
	}
}
