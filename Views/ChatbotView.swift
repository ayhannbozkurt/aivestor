//
//  ChatbotWelcomeView.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 11.12.2024.
//

import SwiftUI

// Sohbet mesaj modeli
struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: MessageSender
    let text: String
}

enum MessageSender {
    case user
    case bot
}

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(sender: .bot, text: "Merhaba! Size nasıl yardımcı olabilirim?")
    ]
    
    func sendMessage(_ text: String) {
        // Kullanıcı mesajı ekle
        messages.append(ChatMessage(sender: .user, text: text))
        
        // Bot yanıtı ekle (Mock yanıt)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let botResponse = self.getMockResponse(for: text)
            self.messages.append(ChatMessage(sender: .bot, text: botResponse))
        }
    }
    
    private func getMockResponse(for text: String) -> String {
        // Basit yanıtlar için mock
        if text.lowercased().contains("merhaba") {
            return "Merhaba! Size nasıl yardımcı olabilirim?"
        } else if text.lowercased().contains("portföy") {
            return "Portföyünüzü büyütmek için yatırım hedeflerinizi gözden geçirebilirsiniz."
        } else {
            return "Anlamadım, tekrar deneyebilir misiniz?"
        }
    }
}

struct ChatbotView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userInput: String = ""
    
    var body: some View {
        ZStack {
            // Arka plan
            LinearGradient(
                gradient: Gradient(colors: [Color("background"), Color.gray.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Mesajlar Listesi
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.messages) { message in
                                HStack {
                                    if message.sender == .bot {
                                        Text(message.text)
                                            .padding()
                                            .background(Color.custom.opacity(0.9))
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                                        Spacer()
                                    } else {
                                        Spacer()
                                        Text(message.text)
                                            .padding()
                                            .background(Color("chatColor").opacity(0.9))
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
                                    }
                                }
                            }
                        }
                        .padding()
                        .onChange(of: viewModel.messages.count) { _ in
                            scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                // Kullanıcı girdi alanı
                HStack {
                    TextField("Mesaj yaz...", text: $userInput)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    
                    Button(action: {
                        if !userInput.isEmpty {
                            viewModel.sendMessage(userInput)
                            userInput = ""
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 8)
                }
                .padding()
            }
        }
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}
