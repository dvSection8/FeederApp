//
//  ProductCell.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell, ViewReusable {
    private struct Dimensions {
        static var spacing: CGFloat = 8
    }
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    lazy private(set) var productView: ProductView = {
        let pv = ProductView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        
        return pv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    // TODO: Implement this if needed
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(productView)
        NSLayoutConstraint.activate([
            productView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimensions.spacing),
            productView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Dimensions.spacing),
            productView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Dimensions.spacing),
            productView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimensions.spacing),
            ])
    }
}
