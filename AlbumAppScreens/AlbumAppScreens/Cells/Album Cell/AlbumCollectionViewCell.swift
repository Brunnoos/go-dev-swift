//
//  AlbumCollectionViewCell.swift
//  AlbumAppScreens
//
//  Created by Aloc FL00030 on 19/03/22.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    static let identifier = "AlbumCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(albumImage: UIImage, albumName: String, trackName: String) {
        albumImageView.image = albumImage
        albumNameLabel.text = albumName
        trackNameLabel.text = trackName
    }

}
