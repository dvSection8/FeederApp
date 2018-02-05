//
//  ProductView.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class ProductView: UIView {
    private struct Dimensions {
        static var imageSize = CGSize(width: 100, height: 100)
        static var spacing: CGFloat = 8
    }
    
    lazy private(set) var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy private(set) var pubDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy private(set) var prodImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    lazy private(set) var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(pubDateLabel)
        stackView.addArrangedSubview(ratingLabel)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Dimensions.spacing
        
        return stackView
    }()
    
    lazy private(set) var ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    // TODO: Implement this if needed
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(prodImage)
        NSLayoutConstraint.activate([
            prodImage.topAnchor.constraint(equalTo: topAnchor),
            prodImage.leftAnchor.constraint(equalTo: leftAnchor),
            prodImage.heightAnchor.constraint(equalToConstant: Dimensions.imageSize.height),
            prodImage.widthAnchor.constraint(equalToConstant: Dimensions.imageSize.width)
            ])
        
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: prodImage.rightAnchor, constant: Dimensions.spacing),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Dimensions.spacing),
            contentStackView.topAnchor.constraint(equalTo: prodImage.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.heightAnchor.constraint(greaterThanOrEqualTo: prodImage.heightAnchor, multiplier: 1)
            ])
    }
}
