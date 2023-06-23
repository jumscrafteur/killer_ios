//
//  BonusIconsComponent.swift
//  Killer
//
//  Created by Hugo Sansane on 22/06/2023.
//

import SwiftUI

struct BonusIconsComponent: View {
    let icon: String
    let text: String
    let isActive: Bool
    
    var body: some View {
        VStack() {
            
            Image(icon).resizable().scaledToFit().opacity(isActive ? 1: 0.6)
            Text(text)
                .font(Font.custom("Staatliches-Regular", size: 18))
                .foregroundColor(isActive ? .white : .gray)
                .multilineTextAlignment(.center)

        }.frame(width: 128)

    }
}
