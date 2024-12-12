//
//  StockModel.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 12.12.2024.
//


import Foundation
import SwiftUI

struct StockData: Codable {
    struct Chart: Codable {
        struct Result: Codable {
            struct Meta: Codable {
                let symbol: String
            }
            struct Indicators: Codable {
                struct Quote: Codable {
                    let close: [Double]?
                }
                let quote: [Quote]
            }
            let meta: Meta
            let indicators: Indicators
        }
        let result: [Result]?
    }
    let chart: Chart?
}



struct StockModel: Identifiable {
    let id = UUID()
    let symbol: String
    let closePrices: [Double]?
    let percentageChange: String
}


