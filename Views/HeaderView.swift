//
//  HeaderView.swift
//  AiVestor
//
//  Created by Emine CETINKAYA on 12.12.2024.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var showSheet: Bool
    
    var body: some View {
            HStack {
                Text("Yatırımlarım")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.darkBlue)
                
                Spacer()
                
                Button(action: {
                    showSheet.toggle()
                }) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .accentColor(Color.darkBlue)
                        .font(.system(size: 40))
                }
            }
        
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//            .padding()
//    }
//}
