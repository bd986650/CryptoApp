//
//  CardView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import SwiftUI

struct CardView<Content>: View where Content: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
    }
}

struct CardFrontView: View {
    
    let name: String
    let cardNumber: String
    let date: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "dot.radiowaves.forward")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                
                Spacer()
                
                VStack(alignment: .center, spacing: 1) {
                    Text("VISA")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    
                    Text("Infinite")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
            }
            
            Spacer()
            Spacer()
            
            HStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(name.uppercased())
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(cardNumber)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Date")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        
                        Text(date)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        
                    }
                }
            }
        }
        .frame(width: 330, height: 180)
        .padding()
        .background(LinearGradient(colors: [Color.black, Color.black], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10)
    }
}

struct CardBackView: View {
    
    let cvv: String
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 15) {
            Spacer()
            
            HStack {
                
                Text(cvv)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .rotation3DEffect(.degrees(180),
                                      axis: (x: 0.0, y: 1.0, z: 0.0))
                
                Text("SECURITY CODE: ")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .rotation3DEffect(.degrees(180),
                                      axis: (x: 0.0, y: 1.0, z: 0.0))
                
                Spacer()
            }
        }
        .frame(width: 330, height: 180)
        .padding()
        .background(LinearGradient(colors: [Color.black, Color.black], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10)
    }
}

