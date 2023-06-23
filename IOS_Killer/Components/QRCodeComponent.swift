//
//  QRCodeComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 10/05/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

struct QRCodeComponent: View {
    let content: String
    @State var qrCodeData:Data = Data()
    
    var body: some View {
        Image(uiImage: UIImage(data: qrCodeData) ?? UIImage())
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .task {
                qrCodeData =  await generateQR(string: content)!
            }
    }
    
    func generateQR(string: String) async -> Data? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.correctionLevel = "L"

        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
}

struct QRCodeComponent_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeComponent(content:"https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    }
}
