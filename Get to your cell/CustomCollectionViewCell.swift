//
//  CustomCollectionViewCell.swift
//  Get to your cell
//
//  Created by ヴィヤヴャハレ・アディティヤ on 01/11/23.
//

import UIKit
///this was used in delegate pattern to trigger the tableview selection
//protocol CollectionViewCellDelegate: AnyObject {
//    func collectionViewCellDidBecomeVisible(_ cell: CustomCollectionViewCell)
//}

class CustomCollectionViewCell: UICollectionViewCell {
    
    ///this was used in delegate pattern to trigger the tableview selection
    //    weak var delegate: CollectionViewCellDelegate?
    
    static let cellIdentifier = "CustomCollectionviewCell"
    
    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleToFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 7
        return cellImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellImageView.heightAnchor.constraint(equalTo: cellImageView.widthAnchor, multiplier: 9.0/16.0)
        ])
    }
    
    ///this method was used in delegate pattern to trigger the tableview selection
    //    override func didMoveToWindow() {
    //        super.didMoveToWindow()
    //        if window != nil {
    //            delegate?.collectionViewCellDidBecomeVisible(self)
    //        }
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
