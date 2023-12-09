//
//  ContentView.swift
//  Instafilter
//
//  Created by Adnan Boxwala on 26.11.23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 20.0
    @State private var filterScale = 1.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture { showingImagePicker = true }
                
                HStack {
                    Text("Intensity")
                    Spacer()
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { applyProcessing() }
                        .disabled(!currentFilter.inputKeys.contains(kCIInputIntensityKey))
                }
                .padding(.top)
                
                HStack {
                    Text("Radius   ") // added whitespace for uniform slider length
                    Slider(value: $filterRadius, in: 1...200)
                        .onChange(of: filterRadius) { applyProcessing() }
                        .disabled(!currentFilter.inputKeys.contains(kCIInputRadiusKey))
                }
                
                HStack {
                    Text("Scale     ") // added whitespace for uniform slider length
                    Slider(value: $filterScale, in: 1...10)
                        .onChange(of: filterScale) { applyProcessing() }
                        .disabled(!currentFilter.inputKeys.contains(kCIInputScaleKey))
                }
                .padding(.bottom)
                
                HStack(alignment: .top) {
                    VStack {
                        Button("Change Filter") { showingFilterSheet = true }
                            
                        Text(CIFilter.localizedName(forFilterName: currentFilter.name) ?? "")
                            .font(.caption)
                            .opacity(0.5)
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Pointillize") { setFilter(CIFilter.pointillize()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Thermal") { setFilter(CIFilter.thermal()) }
                Button("Unsharp Mark") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
            .alert("Verify permission settings.", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text("Instafilter would like to access the camera. Please change permission settings for your app in Settings > Privacy.")
            }

        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .notDetermined, .denied:
            showingAlert = true
        default:
            break
        }
        
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    ContentView()
}
