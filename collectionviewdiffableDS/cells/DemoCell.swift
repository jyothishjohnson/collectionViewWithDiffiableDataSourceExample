//
//  DemoCell.swift
//  collectionviewdiffableDS
//
//  Created by jyothish.johnson on 14/10/20.
//

import UIKit

class DemoCell: UICollectionViewCell {

    @IBOutlet weak var sampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sampleLabel.textColor = .white
        self.contentView.backgroundColor = .lightGray
    }

}
