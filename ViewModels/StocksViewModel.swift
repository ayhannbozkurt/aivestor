//
//  StocksViewModel.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 12.12.2024.
//

import Foundation
import SwiftUI

class StocksViewModel: ObservableObject {
    @Published var stocks: [StockModel] = [] // Holds the list of stocks
    @Published var errorMessage: String?

    private let apiKey = "39b1ed8d32msh3b123f09eed9734p12bf4djsnfc071556abb8"

    // List of stock symbols to fetch
    private let stocksToFetch = ["THYAO.IS", "TUPRS.IS", "DOAS.IS", "BIMAS.IS", "PETKM.IS"]

    func fetchMultipleStockData() {
        for symbol in stocksToFetch {
            fetchStockData(symbol: symbol, range: "1d", interval: "5m")
        }
    }

    private func fetchStockData(symbol: String, range: String, interval: String) {
        let urlString = "https://yahoo-finance166.p.rapidapi.com/api/stock/get-chart?symbol=\(symbol)&range=\(range)&interval=\(interval)&region=TR"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("yahoo-finance166.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                DispatchQueue.main.async {
                    self.errorMessage = "HTTP Error Code: \(response.statusCode)"
                }
                return
            }

            guard let data = data else { return }

            do {
                let decodedData = try JSONDecoder().decode(StockData.self, from: data)
                DispatchQueue.main.async {
                    self.processStockData(decodedData, symbol: symbol)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to process data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func processStockData(_ data: StockData, symbol: String) {
        guard let result = data.chart?.result?.first,
              let closePrices = result.indicators.quote.first?.close,
              let lastClose = closePrices.last else {
            self.errorMessage = "Data unavailable for \(symbol)"
            return
        }

        let percentageChange = calculatePercentageChange(closePrices)

        let stock = StockModel(
            symbol: symbol,
            closePrices: closePrices,
            percentageChange: percentageChange
        )

        self.stocks.append(stock)
    }

    private func calculatePercentageChange(_ prices: [Double]) -> String {
        guard prices.count >= 2 else { return "0.0" }
        let latestPrice = prices.last ?? 0.0
        let previousPrice = prices[prices.count - 2]
        let percentageChange = ((latestPrice - previousPrice) / previousPrice) * 100
        return String(format: "%.2f", percentageChange)
    }
}

