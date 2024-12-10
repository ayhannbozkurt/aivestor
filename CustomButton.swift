//
//  CustomButton.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .blue
    var font: Font = .headline
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 10
    var padding: CGFloat = 12
    var imageName: String?
    var systemImageName: String?
    var imageFrame: CGSize?
    var isEnabled: Bool = true

    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }, label: {
            HStack {
                if let systemImageName {
                    Image(systemName: systemImageName)
                        .frame(width: imageFrame?.width, height: imageFrame?.height)
                        .foregroundColor(foregroundColor)
                } else if let imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageFrame?.width, height: imageFrame?.height)
                }

                Spacer()

                Text(title)
                    .font(font)
                    .foregroundColor(isEnabled ? foregroundColor : .gray)

                Spacer()
            }
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(isEnabled ? backgroundColor : Color.gray.opacity(0.5))
            .cornerRadius(cornerRadius)
            .shadow(radius: isEnabled ? 3 : 0)
        })
        .accessibility(label: Text(title))
        .accessibility(addTraits: .isButton)
        .disabled(!isEnabled)
    }
}
