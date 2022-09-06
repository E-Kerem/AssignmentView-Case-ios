 //
//  MyCollectionViewCell.swift
//  AssignmentView-Case-ios
//
//  Created by Efe Kerem Kesgin on 6.09.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = UIImage(named: "emptyimage")
    }
}
