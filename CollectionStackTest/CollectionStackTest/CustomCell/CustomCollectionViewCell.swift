//
//  CustomCollectionViewCell.swift
//  CollectionStackTest
//
//  Created by Aloc FL00030 on 18/03/22.
//

import UIKit

struct DataCell {
    var image : String
    var label1: String
    var label2: String
    var label3: String
}

class CustomCollectionViewCell: UICollectionViewCell {

    static let idendifier = "CustomCollectionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: DataCell) {
        
    }

}
