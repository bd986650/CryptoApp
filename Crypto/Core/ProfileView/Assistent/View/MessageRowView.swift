//
//  MessageRowView.swift
//  Crypto
//
//  Created by qwotic on 12.02.23.
//

import SwiftUI

struct MessageRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    let message: MessageRow
    let retryCallback: (MessageRow) -> Void
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        VStack(spacing: 0) {
            
            if let text = message.sendText {
                HStack {
                    Spacer()
                    messageRow(text: text)
                        .onTapGesture {
                            pasteboard.string = message.responseText
                            HapticManager.playNotificationHaptic(.success)
                        }
                }
                .padding(.vertical, 5)
            }
            
            if let text = message.responseText {
                HStack {
                    messageRow(text: text, responseError: message.responseError, showDotLoader: message.isInteractingWithChatGPT)
                        .onTapGesture {
                            pasteboard.string = message.responseText
                            HapticManager.playNotificationHaptic(.success)
                        }
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            
        }
        .padding(.horizontal, 20)
        
    }
    
    func messageRow(text: String, responseError: String? = nil, showDotLoader: Bool = false) -> some View {
        VStack(alignment: .leading) {
            if !text.isEmpty {
                Text(text)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(text == message.sendText ? .black : .white)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
            }
            
            if let error = responseError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                
                Button("Regenerate response") {
                    retryCallback(message)
                }
                .foregroundColor(.blue)
            }
            
            if showDotLoader {
                DotLoader(color: .gray)
                    .opacity(0.5)
                    .frame(width: 50, height: 25)
            }
        }
        .padding(15)
        .background(text == message.sendText ? RoundedCorners(tl: 35, tr: 10, bl: 35, br: 35).fill(Color("Gray")) : RoundedCorners(tl: 35, tr: 35, bl: 10, br: 35).fill(Color("Black")))
    }
}
