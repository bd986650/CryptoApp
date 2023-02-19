//
//  ImagePicker.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias imagePickerController = UIImagePickerController
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool

    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShown: $isShown)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var isShown: Bool
        var sourceType: UIImagePickerController.SourceType = .camera
        
        init(image: Binding<UIImage?    >, isShown: Binding<Bool>) {
            _image = image
            _isShown = isShown
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
                isShown = false
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}
