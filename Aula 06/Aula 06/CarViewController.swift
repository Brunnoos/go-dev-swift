//
//  CarViewController.swift
//  Aula 06
//
//  Created by Aloc FL00030 on 16/03/22.
//

import UIKit

class CarViewController: UIViewController {

    private var carData : CarCell = CarCell(imageSource: "", carName: "")
    
    @IBOutlet private weak var carImageView : UIImageView!
    @IBOutlet private weak var carNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showCar()
    }
    
    func configureScreenData(carData : CarCell) {
        self.carData = carData
    }
    
    private func showCar() {
        if carData.carName != "" {
            carNameLabel.text = carData.carName
        }
        
        if carData.imageSource != ""{
            carImageView.image = UIImage(named: carData.imageSource)
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
