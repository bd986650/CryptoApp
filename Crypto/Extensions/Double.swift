//
//  Double.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation

extension Double {
    func convertToCurency() -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
