//
//  TabBarView.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 12.12.2024.
//

import SwiftUI
import Foundation

struct TabBarView: View {
    @Binding var selectedTab: ContentView.Tab
    @Binding var showRewardsView: Bool // Rewards View kontrolü

    var body: some View {
        HStack {
            TabBarButton(icon: "chart.bar", title: "", tab: .profile, selectedTab: $selectedTab)
                .foregroundColor(Color("CustomColor"))
                
            TabBarButton(icon: "creditcard", title: "", tab: .portfolio, selectedTab: $selectedTab)
                .foregroundColor(Color("CustomColor"))
            
            // Merkezi Diamond Butonu
            Button(action: {
                showRewardsView = true // Rewards View'i aç
            }) {
                Image("Diamond")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70) // İstenilen boyut
                    .padding(6)
            }
            .offset(y: -30) // Yukarı kaydırma
            
            TabBarButton(icon: "book", title: "", tab: .search, selectedTab: $selectedTab)
                .foregroundColor(Color("CustomColor"))
            TabBarButton(icon: "checkmark.circle", title: "", tab: .favorites, selectedTab: $selectedTab)
                .foregroundColor(Color("CustomColor"))
        }
        .padding(.horizontal)
        .frame(height: 70)
        .background(Color(.white))
        .shadow(radius: 4)
    }
}

struct TabBarButton: View {
    let icon: String
    let title: String
    let tab: ContentView.Tab
    @Binding var selectedTab: ContentView.Tab
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
