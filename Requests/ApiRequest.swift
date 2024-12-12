//
//  ApiRequest.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 12.12.2024.
//

import Foundation

//class ApiRequest {
//        private var stockData: StockData?
//        private var errorMessage: String?
//        private let apiKey = "39b1ed8d32msh3b123f09eed9734p12bf4djsnfc071556abb8"
//
//    private func fetchStockData(symbol: String, range: String, interval: String) {
//            let urlString = //"https://yahoo-finance166.p.rapidapi//.com/api/stock/get-chart?symbol=\(symbol)&range=\(range)&interval=\(interval)&region=TR"
//            guard let url = URL(string: urlString) else { return }
//
//            var request = URLRequest(url: url)
//            request.setValue("yahoo-finance166.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//            request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    DispatchQueue.main.async {
//                        self.errorMessage = error.localizedDescription
//                    }
//                    return
//                }
//
//                if let response = response as? HTTPURLResponse {
//                    print("Status Code: \(response.statusCode)")
//                    if response.statusCode != 200 {
//                        DispatchQueue.main.async {
//                            self.errorMessage = "HTTP Hata Kodu: \(response.statusCode)"
//                        }
//                        return
//                    }
//                }
//
//                guard let data = data else { return }
//                print("Raw Response: \(String(data: data, encoding: .utf8) ?? "No Data")")
//
//                do {
//                    let decodedData = try JSONDecoder().decode(StockData.self, from: data)
//                    DispatchQueue.main.async {
//                        self.stockData = decodedData
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self.errorMessage = "Veriler işlenemedi: \(error.localizedDescription)"
//                    }
//                    print("Decoding Error: \(error)")
//                }
//            }.resume()
//        }
//
//}
//
