//
//  AnimatedImage.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 20/06/2023.
//

import SwiftUI

struct AnimatedImage: View {
    @State private var image: Image
    let imageName: String
    @State private var index = 0
    @State var animationDuration : Int
    
    init(imageName: String, index: Int = 0, animationDuration: Int) {
        
        
        self.imageName = imageName
        self.index = index
        self.animationDuration = animationDuration
        self.index = 0
        
        self.image = Image(self.imageName + "_" + String(0))
    }

    var body: some View {
        Group {
            image
                .resizable()
                .scaledToFit()
        }.onAppear(perform: {
            self.animate()
        })
    }

    private func animate() {
        Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            self.index = (self.index + 1) % self.animationDuration

            self.image = Image(self.imageName + "_" + String(self.index))
        }
    }
}
