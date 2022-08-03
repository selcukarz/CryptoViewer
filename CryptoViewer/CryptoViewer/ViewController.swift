//
//  ViewController.swift
//  CryptoViewer
//
//  Created by muzaffer on 16.07.2022.
//

import UIKit

class ViewController: UICollectionViewController, UISearchResultsUpdating,UICollectionViewDelegateFlowLayout {
    
    var coins = [Coin](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        title = "Crypto List"
        
        getUrl(completion: {response, err in
            self.coins = response!
        })
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            print(text)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CryptoCollectionViewCell else {
            fatalError("CryptoCollectionViewCell not found")
        }
        let coin = coins[indexPath.row]
        cell.id.text = coin.name
        //imageView.image = coin.icon
        cell.priceChange1D.text = coin.priceChange1D?.description
        if cell.priceChange1D.text!.starts(with: "-") {
            cell.priceChange1D.textColor =  UIColor.red
        } else {
            cell.priceChange1D.textColor =  UIColor.green
        }
        cell.symbol.text = coin.symbol
        cell.price.text = coin.price?.description
        ///
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    func getUrl(completion: @escaping ([Coin]?, Error?) -> ()) {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let coinResult = try JSONDecoder().decode(CoinModel.self, from: data)
                completion(coinResult.coins, nil)
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                completion(nil, jsonError)
            }

        }
        task.resume()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }
    
}



