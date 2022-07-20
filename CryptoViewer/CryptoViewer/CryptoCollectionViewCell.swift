//
//  CryptoCollectionViewCell.swift
//  CryptoViewer
//
//  Created by muzaffer on 19.07.2022.
//

import UIKit

class CryptoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var id : UILabel?
    @IBOutlet weak var symbol : UILabel?
    @IBOutlet weak var price : UILabel?
    @IBOutlet weak var priceChange1D : UILabel?    
}
