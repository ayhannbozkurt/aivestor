//
//  ChatbotWelcomeView.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 11.12.2024.
//

import SwiftUI

struct ChatbotView: View {
    var body: some View {
        ZStack {
            // Arkaplan
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                ZStack {
                    Image("logo") // Örnek ikon
                        .resizable()
                        .foregroundColor(.purple)
                        .frame(width: 80, height: 80)
                }

                // Metinler
                VStack(spacing: 8) {
                    Text("Welcome to ..")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Your Personal Finance Assistant")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()
                HStack {
                    TextField("or, you can type here or speak", text: .constant(""))
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                .padding()

                Spacer()
            }
            .padding()
        }
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}
