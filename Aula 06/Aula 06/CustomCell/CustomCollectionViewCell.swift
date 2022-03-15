//
//  CustomCollectionViewCell.swift
//  Aula 06
//
//  Created by Aloc FL00030 on 14/03/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageBlock: UIImageView!
    
    func setup(imageSource: String) {
        imageBlock.image = UIImage(named: imageSource)
    }
}
