//
//  AssistentView.swift
//  Crypto
//
//  Created by qwotic on 12.02.2023.
//

import SwiftUI

struct AssistentView: View {
    
    @ObservedObject var assistentVM: AssistentViewModel
    
    @FocusState var isTextFieldFocused: Bool
    
    @State private var questions = ["Who are you?", "What is PolkaDot?", "Where can I buy NFT?", "What is Binance?"]
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(assistentVM.messages) { message in
                                MessageRowView(message: message) { message in
                                    Task { @MainActor in
                                        await assistentVM.retry(message: message)
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            isTextFieldFocused = false
                        }
                    }
                }
                .onChange(of: assistentVM.messages.last?.responseText) { _ in  scrollToBottom(proxy: proxy)
                }
            }
            
            if assistentVM.messages.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(questions, id: \.count) { question in
                            Button {
                                assistentVM.inputMessage = question
                                Task { @MainActor in
                                    isTextFieldFocused = false
                                    await assistentVM.sendTapped()
                                }
                            } label: {
                                Text(question)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal, 10)
            }
            
            bottomView()
            
        }
        .navigationTitle("Personal AI Assistent")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    assistentVM.messages.removeAll()
                } label: {
                    Image(systemName: "trash.fill")
                }
                .disabled(assistentVM.isInteractingWithChatGPT)
            }
        }
    }
    
    func bottomView() -> some View {
        HStack {
            TextField("Type something...", text: $assistentVM.inputMessage, axis: .vertical)
                .padding()
                .accentColor(.white)
                .focused($isTextFieldFocused)
            
            if assistentVM.inputMessage != "" {
                Button {
                    assistentVM.inputMessage = ""
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundColor(.white)
                }
                .disabled(assistentVM.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            
            Button {
                Task { @MainActor in
                    isTextFieldFocused = false
                    await assistentVM.sendTapped()
                }
            } label: {
                Image(systemName: assistentVM.inputMessage == "" ? "circle" : "arrow.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .scaleEffect(assistentVM.inputMessage == "" ? 1.0 : 1.3)
                    .foregroundColor(assistentVM.inputMessage == "" ? .white.opacity(0.6) : .white)
                    .padding()
            }
            .disabled(assistentVM.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal, 16)
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = assistentVM.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct AssistentView_Previews: PreviewProvider {
    static var previews: some View {
        AssistentView(assistentVM: AssistentViewModel(api: AssistentDataService(apiKey: API.openAIKey)))
    }
}
