import SwiftUI

struct StockCardsView: View {
    
    let stockModel: StockModel
    
    var body: some View {
        Button(action: {
            print("Card tapped for \(stockModel.symbol)")
        }) {
            VStack {
                HStack {
                    // Load the image from Assets folder
                    Image(stockModel.symbol)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)

                    VStack(alignment: .leading) {
                        Text(stockModel.symbol)
                            .bold()
                            .font(.title3)
                        Text(stockModel.symbol)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    Spacer()
                    
                    Text(
                        (((stockModel.closePrices?.last ?? 0.0) >= (stockModel.closePrices?.first ?? 0.0)) ? "+" : "") +
                        "\(String(format: "%.2f", percentageChange()))%"
                    )
                    .foregroundColor((percentageChange() >= 0.0) ? Color.green : Color.red)
                    .bold()
                    .font(.title3)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("\(String(format: "%.2f TRY", stockModel.closePrices?.last ?? 0.0))")
                        .bold()
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .padding(5)
            .frame(height: UIScreen.main.bounds.height / 8)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 30)
                .stroke(.gray)
            )
        }
        .buttonStyle(PlainButtonStyle()) // Removes button styling to keep the card's appearance
    }
    
    private func percentageChange() -> Double {
        guard let first = stockModel.closePrices?.first, let last = stockModel.closePrices?.last, first != 0 else {
            return 0.0
        }
        return ((last - first) / first) * 100
    }
}

// Example Preview
struct StockCardsView_Previews: PreviewProvider {
    static var previews: some View {
        StockCardsView(stockModel: StockModel(symbol: "AAPL", closePrices: [150.0, 155.0], percentageChange: "2"))
    }
}
