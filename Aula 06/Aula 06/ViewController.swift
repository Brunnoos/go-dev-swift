//
//  ViewController.swift
//  Aula 06
//
//  Created by Aloc FL00030 on 14/03/22.
//

import UIKit

struct CarCell {
    let imageSource: String
    let carName: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var splashCollectionView: UICollectionView!
    @IBOutlet weak var collectionView : UICollectionView!
    
    var cars: [CarCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegates()
        createCars()
        registerCells()
        setupLayout()
    }

    private func delegates() {
        splashCollectionView.delegate = self
        splashCollectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        let nibA = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        let nibB = UINib(nibName: SplashCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nibA, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        splashCollectionView.register(nibB, forCellWithReuseIdentifier: SplashCollectionViewCell.identifier)
    }
    
    private func createCars() {
        cars = []
        cars.append(CarCell(imageSource: "Lamborghini", carName: "Lamborguini"))
        cars.append(CarCell(imageSource: "Nissan", carName: "Nissan"))
        
        cars.append(CarCell(imageSource: "FType", carName: "Ftype"))
        cars.append(CarCell(imageSource: "Mustang", carName: "Mustang"))
        cars.append(CarCell(imageSource: "Porsche", carName: "Porsche"))
        cars.append(CarCell(imageSource: "Chevrolet", carName: "Chevrolet"))
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 124, height: 124)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        let splashLayout = UICollectionViewFlowLayout()
        splashLayout.itemSize = CGSize(width: 248, height: 124)
        splashLayout.minimumLineSpacing = 10
        splashLayout.scrollDirection = .horizontal
        splashCollectionView.collectionViewLayout = splashLayout
        
        splashCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CarViewSegue" {
            if let carViewController = segue.destination as? CarViewController,
                let senderData = sender as? CarCell {
                print(senderData)
                carViewController.configureScreenData(carData: senderData)
            }
        }
    }
}

// Collection Cells
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == splashCollectionView) ? 2 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == splashCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SplashCollectionViewCell.identifier, for: indexPath) as? SplashCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(imageSource: cars[indexPath.row].imageSource)
            
            return cell
        }
        else if collectionView == self.collectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(imageSource: cars[indexPath.row + 2].imageSource)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == splashCollectionView {
            performSegue(withIdentifier: "CarViewSegue", sender: cars[indexPath.row])
        }
        else if collectionView == self.collectionView {
            performSegue(withIdentifier: "CarViewSegue", sender: cars[indexPath.row + 2])
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
