//
//  ValidationUtils.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import Foundation

enum ValidationUtils {
    static func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }

    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 8
    }

    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneFormat = "^[0-9]{10,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
        return phonePredicate.evaluate(with: phoneNumber)
    }

    static func formatPhoneNumber(_ number: String, countryCode: String = "90") -> String {
        let cleanedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        return "+\(countryCode)\(cleanedNumber)"
    }
}
