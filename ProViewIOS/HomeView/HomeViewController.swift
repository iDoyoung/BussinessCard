//
//  HomeViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/05.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel = ViewModel().card
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
    }

    @IBAction func showMore(_ sender: UIButton) {
        
    }
    
    
}

//MARK: - Collection View
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as? CardViewCell else {
            return UICollectionViewCell()
        }
        cell.updateCardUI(card: viewModel)
        return cell
    }
}
