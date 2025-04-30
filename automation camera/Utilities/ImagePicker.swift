//
//  ImagePickerView.swift
//  automation camera
//
//  Created by acqmal on 5/1/25.
//

import SwiftUI
import Foundation

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var didTapCapture: Bool?
    @Binding var flash: Bool
    @Binding var camerDevice: Int
    
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.showsCameraControls = false
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        let cameraAspectRatio: CGFloat = 4.0/3.0
        let imageHeight = screenWidth * cameraAspectRatio
        let scale = ceil((screenHeight / imageHeight) * 10.0) / 10.0
        var transform = CGAffineTransform(translationX: 0, y: (screenHeight - imageHeight) / 2)
        transform = transform.scaledBy(x: scale, y: scale)
        imagePicker.cameraViewTransform = transform
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if (didTapCapture == true) {
            uiViewController.takePicture()
            
        }
        
        if(flash == true) {
            uiViewController.cameraFlashMode = .on
        }else {
            uiViewController.cameraFlashMode = .off
        }
        
        if(camerDevice == Camera.Rear.rawValue) {
            uiViewController.cameraDevice = .rear
        }else {
            uiViewController.cameraDevice = .front
        }
    }
    
}

