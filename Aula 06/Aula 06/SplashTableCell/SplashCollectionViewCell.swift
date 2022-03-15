//
//  SplashTableViewCell.swift
//  Aula 06
//
//  Created by Aloc FL00030 on 14/03/22.
//

import UIKit

class SplashCollectionViewCell: UICollectionViewCell {

    static let identifier = "SplashCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageBlock: UIImageView!
    @IBOutlet weak var labelBlock: UILabel!
    
    func setup(imageSource: String) {
        imageBlock.image = UIImage(named: imageSource)
        labelBlock.text = imageSource
    }
    
}
