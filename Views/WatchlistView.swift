import SwiftUI

struct WatchlistView: View {
    @StateObject private var stocksVM = StocksViewModel() // Bind to ViewModel instance

    var body: some View {
        NavigationView {
            VStack {
                // Header Section
                HStack {
                    Text("Portföyüm")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.darkBlue)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)

                // Loading and Error Handling
                if stocksVM.stocks.isEmpty && stocksVM.errorMessage == nil {
                    VStack {
                        ProgressView("Hisseler Yükleniyor...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .padding()

                        Text("Hisse verileri yükleniyor, lütfen bekleyin.")
                            .foregroundColor(.gray)
                    }
                } else if let errorMessage = stocksVM.errorMessage {
                    Text("Hata: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // Watchlist Section
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(stocksVM.stocks, id: \.symbol) { stock in
                                StockCardsView(stockModel: stock) // Render each stock as a card
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Fetch data for multiple stocks on appear
                stocksVM.fetchMultipleStockData()
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
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
