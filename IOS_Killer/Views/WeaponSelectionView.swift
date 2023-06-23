//
//  WeaponSelectionView.swift
//  Killer
//
//  Created by Hugo Sansane on 22/06/2023.
//

import SwiftUI

struct WeaponSelectionView: View {
    let contract: Contract
    @Binding var selectedWeapon: Weapon?
    
    var body: some View {
        Text("\(contract.target.first_name)\n\(contract.target.last_name)")
            .font(Font.custom("Staatliches-Regular", size: 48))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)

        HStack {
            BonusIconsComponent(icon: "SuperCoupeGorge",
                                 text: "\(contract.weapons[0].points) pts\n\(contract.weapons[0].name)",
                                 isActive: selectedWeapon == contract.weapons[0])
            .onTapGesture {
                selectedWeapon = contract.weapons[0]
            }
            
            Spacer()
            
            BonusIconsComponent(icon: "SuperCoupeGorge",
                                 text: "\(contract.weapons[1].points) pts\n\(contract.weapons[1].name)",
                                 isActive: selectedWeapon == contract.weapons[1])
            .onTapGesture {
                selectedWeapon = contract.weapons[1]
            }
            
        }.padding(.horizontal, 32)

        Spacer()

        ButtonComponent(action: {
            print("kill")
        }, text: "Tuer")
    }
}
