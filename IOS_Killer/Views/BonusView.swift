//
//  BonusView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 16/05/2023.
//

import SwiftUI

struct BonusView: View {
    var body: some View {
        VStack {
            HStack(alignment:.center) {
                BonusIconsComponent(icon: "Reveal", text: "Reveal", isActive: false)
                BonusIconsComponent(icon: "Immunité", text: "Immunité", isActive: false)
            }
            
            HStack(alignment:.center) {
                BonusIconsComponent(icon: "CoupeGorge", text: "Coupe Gorge", isActive: false)
                BonusIconsComponent(icon: "SuperCoupeGorge", text: "Super Coupe Gorge", isActive: false)
            }
            
        }
        
    }
}

struct BonusView_Previews: PreviewProvider {
    static var previews: some View {
        BonusView()
    }
}
