//
//  ViewController.swift
//  CryptoViewer
//
//  Created by muzaffer on 16.07.2022.
//

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
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CryptoCollectionViewCell else {
            fatalError("CryptoCollectionViewCell not found")
        }
        return cell
    }
    func getUrl() {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
