//
//  ColorSlider.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI

struct ColorSlider: View {
    
    @Binding var value: Double
    var tintColor: Color
    
    var body: some View {
        HStack {
            Text(verbatim: "0")
            
            Slider(value: $value, in: 0.0...1.0)
                .tint(tintColor)
            
            Text(verbatim: "255")
            
        }
    }
}
