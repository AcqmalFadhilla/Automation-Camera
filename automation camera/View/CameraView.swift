//
//  ContentView.swift
//  automation camera
//
//  Created by acqmal on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var capturedImage: UIImage?
    @State private var showCapuredImage = false
    @State private var didTapCapture: Bool? = false
    @State private var flash: Bool = false
    @State private var cameraDevice: Int = Camera.Rear.rawValue
    var body: some View {
        VStack {
            ImagePicker(capturedImage: self.$capturedImage,
                        didTapCapture: self.$didTapCapture,
                        flash: self.$flash,
                        camerDevice: self.$cameraDevice,
                        sourceType: .camera)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(
                VStack {
                    HStack(alignment: .bottom) {
                        Image(systemName: flash ? "bolt.fill" : "bolt.slash.fill")
                            .foregroundStyle(.white)
                            .onTapGesture {
                                flash.toggle()
                            }
                        Spacer()
                    }
                    .padding()
                    .padding(.top, 48)
                    .padding(.horizontal, 8)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.1)
                    .background(Color.blue.opacity(0.7))
                    
                    Spacer()
                    
                    HStack {
                        NavigationLink(
                    }
                }
            )
        }.ignoresSafeArea(.all)
    }
}

enum Camera: Int {
    case Rear = 0
    case Front = 1
}

#Preview {
    ContentView()
}
