//
//  SectionHeader.swift
//  MockStore
//
//  Created by Marcus on 1/21/21.
//

import UIKit

class SectionHeader: UICollectionReusableView {
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
		nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
		nameLabel.textColor = .label

		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
		subtitleLabel.textColor = .label
		
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
		
		stackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 5.0).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
	}
}
