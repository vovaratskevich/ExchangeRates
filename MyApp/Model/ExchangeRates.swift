//
//  ExchangeRates.swift
//  MyApp
//
//  Created by Vladimir Ratskevich on 16.08.21.
//

import Foundation

struct ExchangeRatesSum: Decodable {
    
    var downloadDate: String?
    var rates: [Rates]?
}

struct Rates: Decodable {
    
    var currMnemFrom: String?
    var currMnemTo: String?
    var buy: String?
    var sale: String?
}
