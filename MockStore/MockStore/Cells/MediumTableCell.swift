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
		// TODO: implement
	}
	
	
	// MARK: internal properties
	private let nameLabel: UILabel = UILabel(frame: .zero)
	private let subtitleLabel: UILabel = UILabel(frame: .zero)
	private let imageView: UIImageView = UIImageView(frame: .zero)
	private let buyButton: UIButton = UIButton(type: .custom)
	private let labelsStackView: UIStackView = UIStackView(frame: .zero)
	private let imageLabelsButtonStackView: UIStackView = UIStackView(frame: .zero)
	
	
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

		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		subtitleLabel.textColor = .secondaryLabel
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 15.0
		imageView.clipsToBounds = true
		
		buyButton.translatesAutoresizingMaskIntoConstraints = false
		buyButton.backgroundColor = .quaternaryLabel
		buyButton.setTitle("GET", for: .normal)
		buyButton.layer.cornerRadius = 10.0
		
//		labelsStackView.translatesAutoresizingMaskIntoConstraints = false
		labelsStackView.axis = .vertical
		[nameLabel, subtitleLabel].forEach { labelsStackView.addArrangedSubview($0) }
		
		imageLabelsButtonStackView.translatesAutoresizingMaskIntoConstraints = false
		imageLabelsButtonStackView.axis = .horizontal
		[imageView, labelsStackView, buyButton].forEach { imageLabelsButtonStackView.addArrangedSubview($0) }
		contentView.addSubview(imageLabelsButtonStackView)
	}
	private func constrainSubviews() {
		imageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

		imageLabelsButtonStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		imageLabelsButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		imageLabelsButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		imageLabelsButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		
		buyButton.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
		buyButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
	}
}
