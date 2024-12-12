//
//  PortfolioView.swift
//  VakıfbankHackathon
//
//  Created by Seyma on 9.12.2024.
//

import Foundation
import SwiftUI

struct PortfolioView: View {
    @ObservedObject var stocksVM: StocksViewModel
    @Binding var showRewardsView: Bool

    var body: some View {
        VStack {
            HeaderView(showSheet: $showRewardsView)
            PortfolioCardView(stocksVM: stocksVM)
            WatchlistView()
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
}
