//
//  KillView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 16/05/2023.
//

import SwiftUI
import CodeScanner

struct KillView: View {
    @State var player: PlayerExtended?
    @State var selectedWeapon: Weapon?
    
    @State private var isShowingScanner = false
    
    @State var scannedCode: String?
    
    var body: some View {
        VStack {
            if let _player = player {
                if let contract = _player.contract {
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
                        isShowingScanner = selectedWeapon != nil
                    }, text: "Tuer")
                    
                } else {
                    Text("Vous n'avez pas de contrat")
                }
                
            }
            
        }.padding(32)
            .onAppear {
                Task {
                    player = await GameService.getPlayerData() ?? player
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        
                        scannedCode = result.string
                        
                        Task {
                            await GameService.kill(key: scannedCode!, weaponId: selectedWeapon!.id)
                            player = await GameService.getPlayerData() ?? player
                            selectedWeapon = nil
                            isShowingScanner = false
                        }
                        
                        
                        
                        
                        
                    }
                }
            }
    }
}
