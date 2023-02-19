//
//  SplashView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import RiveRuntime
import SwiftUI

struct SplashView: View {
    var body: some View {
        RiveViewModel(fileName: "splash").view()
            .ignoresSafeArea()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
