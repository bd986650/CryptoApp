//
//  PagerTabView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI

struct PagerTabView<Content: View,Label: View>: View {
    var content: Content
    var label: Label
    var tint: Color
    @Binding var selection: Int
    
    init(tint: Color,selection: Binding<Int>,@ViewBuilder labels: @escaping()->Label,@ViewBuilder content: @escaping()->Content ){
        self.content = content()
        self.label = labels()
        self.tint = tint
        self._selection = selection
    }
    @State var offset: CGFloat = 0
    @State var maxTabs: CGFloat = 0
    @State var tabOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                label
            }
            .overlay(
                HStack(spacing: 0){
                    ForEach(0..<Int(maxTabs),id: \.self){index in
                        Rectangle()
                            .fill(Color.black.opacity(0.01))
                            .onTapGesture {
                                let newOffset = CGFloat(index) * getScreenBounds().width
                                self.offset = newOffset
                            }
                    }
                }
            )
            .foregroundColor(tint)
            
            Capsule()
                .fill(tint)
                .padding(.horizontal, 20)
                .frame(width: maxTabs == 0 ? 0 : (getScreenBounds().width / maxTabs),height: 3)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: tabOffset)
            
            OffsetPageTabView(selection: $selection,offset: $offset){
                HStack(spacing: 0){
                    content
                }
                .overlay(
                    GeometryReader{proxy in
                         Color.clear
                            .preference(key: TabPreferenceKey.self, value: proxy.frame(in: .global))
                    }
                
                )
                .onPreferenceChange(TabPreferenceKey.self){proxy in
                    let minX = -proxy.minX
                    let maxWidth = proxy.width
                    let screenWidth = getScreenBounds().width
                    let maxTabs = (maxWidth / screenWidth).rounded()
                    let progress = minX / screenWidth
                    let tabOffset = progress * (screenWidth / maxTabs)
                    
                    self.tabOffset = tabOffset
                    self.maxTabs = maxTabs
                }
            }
        }
    }
}

struct TabPreferenceKey: PreferenceKey{
    static var defaultValue: CGRect = .init()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct OffsetPageTabView<Content: View>: UIViewRepresentable{
    var content: Content
    @Binding var offset: CGFloat
    @Binding var selection: Int

    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    init(selection: Binding<Int>,offset: Binding<CGFloat>, @ViewBuilder content:
         @escaping()->Content){
        self.content = content()
        self._offset = offset
        self._selection = selection
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollview = UIScrollView()
        
        let hostview = UIHostingController(rootView: content)
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostview.view.topAnchor.constraint(equalTo: scrollview.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            hostview.view.heightAnchor.constraint(equalTo: scrollview.heightAnchor),
        ]
        scrollview.addSubview(hostview.view)
        scrollview.addConstraints(constraints)
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.delegate = context.coordinator
        
        return scrollview
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        let currentOffset = uiView.contentOffset.x
        
        if currentOffset != offset{
            print("updating")
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate{
        var parent: OffsetPageTabView
        
         init(parent: OffsetPageTabView) {
             self.parent = parent
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            let maxSize = scrollView.contentSize.width
            let currentSelection = (offset / maxSize).rounded()
            parent.selection = Int(currentSelection)
            parent.offset = offset
        }
    }
}
