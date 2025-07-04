import SwiftUI

struct ContentView: View {
    @StateObject private var stocksVM: StocksViewModel = StocksViewModel()

    @State private var selectedTab: Tab = .profile
    @State private var showRewardsView: Bool = false

    enum Tab {
        case profile, portfolio, favorites, rewards, gamePath, search
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // İçerik Görünümü
            ZStack {
                switch selectedTab {
                case .profile:
                    StocksView()
                case .portfolio:
                    PortfolioView(stocksVM: stocksVM, showRewardsView: $showRewardsView)
                case .favorites:
                    TaskView()
                case .rewards:
                    ChatbotView()
                case .gamePath:
                    TaskView()
                case .search:
                    EducationView()
                }
            }
            Spacer()
            
            // Özelleştirilmiş TabBar
            TabBarView(selectedTab: $selectedTab, showRewardsView: $showRewardsView)
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showRewardsView) {
            ChatbotView()
        }
    }
}
