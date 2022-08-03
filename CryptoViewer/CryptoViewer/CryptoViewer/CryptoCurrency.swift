//
//  CryptoCurrency.swift
//  CryptoViewer
//
//  Created by muzaffer on 22.07.2022.
//


import Foundation

struct CryptoCurrency: Decodable {
    let name: String
    let symbol: String
    let icon: URL
    let price: Int
    let volume: Int
    let priceChange1d: Int
    let marketCap: Int
    let totalSupply: Int
}
 

