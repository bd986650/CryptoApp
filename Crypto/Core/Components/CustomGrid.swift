//
//  CustomGrid.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import SwiftUI

struct CustomGrid<Content: View>: View {
    let columns: Int
    let spacing: CGFloat
    let content: () -> Content
    
    init(columns: Int, spacing: CGFloat = 10, @ViewBuilder content: @escaping () -> Content) {
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = (geometry.size.width - CGFloat(columns - 1) * spacing) / CGFloat(columns)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns), spacing: spacing) {
                    content()
                        .frame(width: width)
                }
            }
        }
    }
}
