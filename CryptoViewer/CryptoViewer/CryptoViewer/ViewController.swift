//
//  ViewController.swift
//  CryptoViewer
//
//  Created by muzaffer on 16.07.2022.
//
import Foundation
import UIKit

class ViewController: UICollectionViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            print(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        title = "Crypto List"
        getUrl()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CryptoCollectionViewCell else {
            fatalError("CryptoCollectionViewCell not found")
        }        
        return cell
    }
    
    func getUrl() {
        let apiurl = URL(string: "https://api.coinstats.app/public/v1/coins")!

        let task = URLSession.shared.dataTask(with: apiurl) {(data, response, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            do {
                let cryptoCurrency = try JSONDecoder().decode(Welcome.self, from: data)
                print(cryptoCurrency)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
// MARK: - Number of Sections
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
        
    }
    
    private let sectionInsets = UIEdgeInsets(
      top: 40.0,
      left: 40.0,
      bottom: 40.0,
      right: 40.0)
    private let itemsPerRow: CGFloat = 2
}

// MARK: - Collection View Flow Layout Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
  // 1
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // 2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  // 3
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}


