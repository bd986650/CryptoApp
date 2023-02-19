//
//  DetailCardView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import SwiftUI

struct DetailCardView: View {
    
    @State private var degress: Double = 0
    @State private var flipped: Bool = false
    
    private let pasteboard = UIPasteboard.general
    var card: Card
    
    var body: some View {
        VStack(spacing: 20){
            CardView {
                VStack {
                    Group {
                        if flipped {
                            CardBackView(cvv: card.cvv ?? "")
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white)
                                }
                        } else {
                            CardFrontView(name: card.name ?? "", cardNumber: card.number ?? "", date: card.date ?? "")
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white)
                                }
                        }
                    }
                    .rotation3DEffect(.degrees(degress),
                                      axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                withAnimation(.spring()){
                    degress += 180
                    flipped.toggle()
                }
            }
            
            Divider()
            
            HStack {
                Text(card.name?.uppercased() ?? "")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                
                Spacer()
                
                Button {
                    pasteboard.string = card.name
                    HapticManager.playNotificationHaptic(.success)
                } label: {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
                }
            }
            
            Divider()
            
            HStack {
                Text(card.number ?? "")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                
                Spacer()
                
                Button {
                    pasteboard.string = card.number
                    HapticManager.playNotificationHaptic(.success)
                } label: {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
                }
            }
            
            Divider()
            
            if flipped {
                HStack {
                    Text(card.cvv ?? "")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Button {
                        pasteboard.string = card.cvv
                        HapticManager.playNotificationHaptic(.success)
                    } label: {
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
                    }
                }
            }
            
            Spacer()
        }
        .padding(20)
    }
}
