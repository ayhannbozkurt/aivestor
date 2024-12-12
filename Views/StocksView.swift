import SwiftUI

struct StocksView: View {
    @StateObject private var stocksVM = StocksViewModel() // ViewModel instance
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hoşgeldin Şeyma")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.darkBlue)
                    Spacer()
                }
                .padding(.horizontal)
                
                if stocksVM.stocks.isEmpty && stocksVM.errorMessage == nil {
                    VStack {
                        ProgressView("Loading Stocks...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .padding()
                        
                        Text("Fetching stock data, please wait...")
                            .foregroundColor(.gray)
                    }
                } else if let errorMessage = stocksVM.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(stocksVM.stocks) { stock in
                                StockCardsView(stockModel: stock)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                stocksVM.fetchMultipleStockData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Ayarlar işlemi
                        print("Ayarlar butonuna basıldı")
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
       
    }
}



