//
//  SectionHeader.swift
//  MockStore
//
//  Created by Marcus on 1/21/21.
//

import UIKit

class SectionHeader: UICollectionReusableView {
	static let reuseIdentifier: String = UUID().uuidString
	
	
	// MARK: accessors
	var nameText: String? {
		didSet {
			if let name = nameText {
				nameLabel.text = name
			}
		}
	}
	var subtitleText: String? {
		didSet {
			if let subtitle = subtitleText {
				subtitleLabel.text = subtitle
			}
		}
	}

	
	// MARK: internal properties
	private let nameLabel: UILabel = UILabel(frame: .zero)
	private let subtitleLabel: UILabel = UILabel(frame: .zero)
	private let stackView: UIStackView = UIStackView(frame: .zero)
	private let separator: UIView = UIView(frame: .zero)
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureSubviews()
		constrainSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in SectionHeader")
	}
	
	
	// MARK: helpers
	private func configureSubviews() {
		nameLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
		nameLabel.textColor = .label

		subtitleLabel.textColor = .secondaryLabel
		
		[nameLabel, subtitleLabel].forEach { stackView.addArrangedSubview($0) }
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 0.0
		addSubview(stackView)
		
		separator.translatesAutoresizingMaskIntoConstraints = false
		separator.backgroundColor = .tertiarySystemFill
		addSubview(separator)
	}
	private func constrainSubviews() {
		separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
		
		stackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10.0).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
	}
}
