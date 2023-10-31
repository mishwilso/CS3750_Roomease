//
//  QRGeneratorView.swift
//  Roomease
//
//  Source: https://jeevatamil.medium.com/create-qr-codes-with-swiftui-e3606a103bc2
//

import SwiftUI

struct QRGeneratorView: View {
    @State private var text = "aOy5PSVosCvqavyITR6d"
    
    var body: some View {
        VStack {
            //text = "aOy5PSVosCvqavyITR6d"
            Image(uiImage: UIImage(data: getQRCodeDate(text: text)!)!)
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
    
    func getQRCodeDate(text: String) -> Data? {
        //Step 3: Create CI Filter Object
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        //Step 2: Convert text into Data
        let data = text.data(using: .ascii, allowLossyConversion: false)
        
        //Step 4: Add data to the filter
        filter.setValue(data, forKey: "inputMessage") 
        
        //Step 5: Create CIImage for CIFilter Object
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        
        //Step 6: Convert CIImage to UIImage object
        let uiimage = UIImage(ciImage: scaledCIImage)
        
        //Step 7: Display image
        return uiimage.pngData()!
    }
}


#Preview {
    QRGeneratorView()
}
