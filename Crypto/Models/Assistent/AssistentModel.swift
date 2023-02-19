//
//  AssistentModel.swift
//  Crypto
//
//  Created by qwotic on 12.02.2023.
//

import SwiftUI

struct CompletionResponse: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let text: String
}

struct MessageRow: Identifiable {
    let id = UUID()
    var isInteractingWithChatGPT: Bool
    let sendText: String
    var responseText: String
    var responseError: String?
}
