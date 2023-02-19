//
//  View.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension View {
    func pageView(ignoreSafeArea: Bool = false, edges: Edge.Set = [])->some View{
        self
            .frame(width: getScreenBounds().width, alignment: .center)
            .ignoresSafeArea(ignoreSafeArea ? .container : .init(), edges: edges)
    }
    
    func getScreenBounds()->CGRect {
        return UIScreen.main.bounds
    }
    
    func ActionSheet(showImagePickerOptions: Binding<Bool>, showImagePicker: Binding<Bool>, sourceType: Binding<UIImagePickerController.SourceType>) -> some View {
        Group {
            self.modifier(ActionSheetModifier(showImagePickerOptions: showImagePickerOptions, showImagePicker: showImagePicker, sourceType: sourceType))
        }
    }
}

