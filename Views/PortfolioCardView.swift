import SwiftUI

struct PortfolioCardView: View {
    @StateObject var stocksVM: StocksViewModel

    var body: some View {
        VStack (alignment: .leading) {
            Text("Portföy Değeri")
                .font(.title2)
                .foregroundColor(Color.gray)
            
            HStack (alignment: .top) {
                // Portföy toplam değerini hesaplama
                let totalValue = stocksVM.stocks.compactMap { $0.closePrices?.last }.reduce(0.0, +)
                
                Text("\(String(format: "%.2f TRY", totalValue))")
                    .bold()
                    .foregroundColor(Color.white)
                    .font(.system(size: 50))
                
                // Örnek bir değişim yüzdesi (isteğe göre güncellenebilir)
                Text("2.8%")
                    .foregroundColor(Color.green)
                    .bold()
                    .font(.title3)
            }
        }
        .padding()
        .frame(height: UIScreen.main.bounds.height / 4.15)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.darkBlue) // Arka plan rengi
        )
    }
}

//struct PortfolioCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioCardView(stocksVM: StocksViewModel())
//    }
//}
