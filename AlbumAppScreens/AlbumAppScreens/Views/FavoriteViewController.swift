//
//  FavoriteViewController.swift
//  AlbumAppScreens
//
//  Created by Aloc FL00030 on 19/03/22.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    private var favoriteAlbums : [AlbumInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Albums Favoritos"
        // Do any additional setup after loading the view.
        delegates()
        setupLayout()
        registerCell()
        createData()
    }
    
    private func delegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.40, height: 164)
        layout.minimumLineSpacing = 12
        
        collectionView.collectionViewLayout = layout
    }
    
    private func registerCell() {
        let nib = UINib(nibName: AlbumCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
    }
    
    private func createData() {
        favoriteAlbums = [.init(albumImage: UIImage(systemName: "ticket")!, albumName: "Teste Album 1", trackNames: ["Teste Track 1", "Teste Track 2","Teste Track 3" ])]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumDetail" {
            if let albumDetailController = segue.destination as? AlbumDetailViewController,
                let sender = sender as? AlbumInfo {
                
                albumDetailController.receiveData(albumInfo: sender, isFavorite: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAlbumDetail", sender: favoriteAlbums[indexPath.row])
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell()}
        
        let album = favoriteAlbums[indexPath.row]
        
        cell.configure(albumImage: album.albumImage, albumName: album.albumName, trackName: album.trackNames[0])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteAlbums.count
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
}

