//
//  Coordinator.swift
//  automation camera
//
//  Created by acqmal on 5/1/25.
//

import Foundation
import SwiftUI

import Photos
import UniformTypeIdentifiers
import MobileCoreServices
import CoreLocation
import CoreLocationUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePicker
    
    init(picker: ImagePicker){
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let capturedImage = info[.originalImage] as? UIImage else { return }
        let data: Data? = capturedImage.jpegData(compressionQuality: 1.0)
        let metaData: NSDictionary = info[.mediaMetadata] as! NSDictionary
        let dictMeta = metaData.swiftDictionary
        saveImageWithImageData(filename: NSUUID().uuidString, data: data! as NSData, properties: dictMeta as NSDictionary)
    }
    
    func saveImageWithImageData(filename: String, data: NSData, properties: NSDictionary){
        let imageRef: CGImageSource = CGImageSourceCreateWithData((data as CFData), nil)!
        
        let uti: CFString = CGImageSourceGetType(imageRef)!
        let dataWithEXIF: NSMutableData = NSMutableData(data: data as Data)
        let destination: CGImageDestination = CGImageDestinationCreateWithData((dataWithEXIF as CFMutableData), uti, 1, nil)!
        
        CGImageDestinationAddImageFromSource(destination, imageRef, 0, (properties as CFDictionary))
        CGImageDestinationFinalize(destination)
        
        let path: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let savePath: String = path[0].appending("/\(filename).jpg")
        
        let manager: FileManager = FileManager.default
        let result = manager.createFile(atPath: savePath, contents: dataWithEXIF as Data, attributes: nil)
        if result {
            print("Image with EXIF saved successfully")
        }
        
    }
}

extension NSDictionary {
    var swiftDictionary: Dictionary<String, Any> {
        var swiftDictionary = Dictionary<String, Any>()
        
        for key: Any in self.allKeys {
            let stringKey = key as! String
            if let keyValye = self.value(forKey: stringKey){
                swiftDictionary[stringKey] = keyValye
            }
        }
        return swiftDictionary
    }
}
