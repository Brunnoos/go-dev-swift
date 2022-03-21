import UIKit


class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegates()
        registerCells()
        setupLayout()
    }

    private func delegates() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        let nibA = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nibA, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 124, height: 124)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
    }
}

// Collection Cells
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
}
