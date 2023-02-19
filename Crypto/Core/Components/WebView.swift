//
//  WebView.swift
//  Crypto
//
//  Created by qwotic on 12.02.2023.
//

import SwiftUI
import WebKit

struct WebView: View {
    
    var title: String
    var link: String
    
    var body: some View {
        WebViewHelper(url: URL(string: link)!)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebViewHelper: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
