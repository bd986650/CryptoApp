//
//  ConnectionErrorView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import RiveRuntime
import SwiftUI

struct ConnectionErrorView: View {
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 60)
            .background(
                Image("Spline")
                    .blur(radius: 100)
                    .offset(x: 100, y: 50)
                    .scaleEffect(1.5)
        )
    }
    
    var body: some View {
        ZStack {
            background
            
            VStack (alignment: .leading, spacing: 30) {
                Text("Oops!..")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Something wrong with your \nconnection, Please try \nagain.")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.7)
                
                Button(action: {
                    
                }) {
                    Text("Retry".uppercased())
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                        .background(Capsule().foregroundColor(.white))
                }
            }
            .padding(.horizontal, 70)
            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
        }
    }
}

struct ConnectionErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionErrorView()
    }
}
