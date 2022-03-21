import UIKit

struct AlbumInfo {
    var albumImage: UIImage
    var albumName: String
    var trackNames: [String]
}

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    
    private var albums : [AlbumInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Albums"
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
        albums = [.init(albumImage: UIImage(systemName: "ticket")!, albumName: "Teste Album 1", trackNames: ["Teste Track 1", "Teste Track 2","Teste Track 3" ]),
                  .init(albumImage: UIImage(systemName: "ticket")!, albumName: "Teste Album 2", trackNames: ["Teste Track 1", "Teste Track 2","Teste Track 3"]),
                  .init(albumImage: UIImage(systemName: "ticket")!, albumName: "Teste Album 3", trackNames: ["Teste Track 1", "Teste Track 2","Teste Track 3" ])]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumDetail" {
            if let albumDetailController = segue.destination as? AlbumDetailViewController,
                let sender = sender as? AlbumInfo {
                
                albumDetailController.receiveData(albumInfo: sender, isFavorite: false)
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

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAlbumDetail", sender: albums[indexPath.row])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell()}
        
        let album = albums[indexPath.row]
        
        cell.configure(albumImage: album.albumImage, albumName: album.albumName, trackName: album.trackNames[0])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
}
