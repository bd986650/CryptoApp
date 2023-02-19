//
//  String.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation

extension String: CustomNSError {
    
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}
