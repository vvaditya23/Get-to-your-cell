//
//  CustomCollectionViewCell.swift
//  Get to your cell
//
//  Created by ヴィヤヴャハレ・アディティヤ on 01/11/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CustomCell"
    
    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        return cellImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
