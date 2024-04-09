//
//  ImagePicker.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.04.2024.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var imageURL: URL?
    
    @ObservedObject private var viewModel = AuthFirebase()
    
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Выберите фотографию")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            
            if let selectedImageData {
                Image(uiImage: UIImage(data: selectedImageData) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            
            Button("Сохранить фотографию") {
                if let imageData = selectedImageData {
                    viewModel.savePhotoToFirebase(imageData: imageData)
                }
            }
            .padding()
            
            if let imageURL = imageURL {
                Text("Ссылка на загруженное изображение: \(imageURL.absoluteString)")
                    .padding()
            }
        }
        .padding()
    }
}
