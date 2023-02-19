//
//  ActionSheet.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI

struct ActionSheetModifier: ViewModifier {

    @Binding var showImagePickerOptions: Bool
    @Binding var showImagePicker: Bool
    @Binding var sourceType: UIImagePickerController.SourceType

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .confirmationDialog("Select Image", isPresented: $showImagePickerOptions, titleVisibility: .visible) {
                    Button("Camera") {
                        sourceType = .camera
                        showImagePicker = true
                    }
                    
                    Button("Open Gallery") {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }
                }
        }
        else {
            content
                .actionSheet(isPresented: $showImagePickerOptions) {
                    ActionSheet(title: Text("Select Image"), buttons: [
                        .default(Text("Camera")) {
                            sourceType = .camera
                            showImagePicker = true

                        },
                        
                        .default(Text("Open Gallery")) {
                            sourceType = .photoLibrary
                            showImagePicker = true
                        },
                        .cancel()
                    ])
                }
        }
    }
}
