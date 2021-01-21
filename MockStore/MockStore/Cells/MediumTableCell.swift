//
//  MediumTableCell.swift
//  MockStore
//
//  Created by Marcus on 1/20/21.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
	// MARK: SelfConfiguringCell conformance
	static var reuseIdentifier: String = UUID().uuidString
	func configure(with app: App) {
		nameLabel.text = app.name
		setSubtitleAttributeText(forString: app.subheading)
		imageView.image = UIImage(named: app.image)
	}
	func showsSeparator(shows: Bool) {
		separator.isHidden = !shows
	}

	
	// MARK: layout constants
	private static let imageViewSize: CGFloat = 50.0
	private static let horizontalStackViewSpacing: CGFloat = 10.0
	private static let verticalStackViewMargin: CGFloat = 2.0
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

		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
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
		labelsStackView.spacing = 2.0
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
	
	private func setSubtitleAttributeText(forString string: String) {
		let attributedString = NSMutableAttributedString(string: string)
		let paragraphStyle = NSMutableParagraphStyle()
		// I swear this negative line spacing has an effect
		// even though documentation says it should not
		paragraphStyle.lineSpacing = -5.0
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
		subtitleLabel.attributedText = attributedString
	}
	
	@objc func buyButtonPressed(_ sender: UIButton) {
		print("Buy button pressed!")
	}
}
