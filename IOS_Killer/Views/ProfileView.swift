//
//  ProfileView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 08/05/2023.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

enum Panels {
    case qrcode
    case bonus
}

struct ProfileView: View {
    @State var player: PlayerExtended?
    @State var game: GameDetailed?
    
    @State var activePanel = Panels.bonus
    
    var body: some View {
        VStack {
            if let _player = player {
                Text("\(_player.first_name) \(_player.last_name)")
                    .font(Font.custom("Staatliches-Regular", size: 48))
                    .foregroundColor(.white)
                
                Text("\(_player.score) points")
                    .font(Font.custom("Staatliches-Regular", size: 48))
                    .foregroundColor(.white)
                
                Spacer()
                    
                if (activePanel == Panels.qrcode) {
                    QRCodeView(player: _player)
                } else if (activePanel == Panels.bonus) {
                    BonusView()
                } else {
                    Text("Erreur Aucune page Valide")
                }
            
                Spacer()
                    
                VStack {
                    HStack {
                        ButtonComponent(action: {
                            activePanel = Panels.qrcode
                        }, text: "QR Code")
                        
                        ButtonComponent(action: {
                            activePanel = Panels.bonus
                        }, text: "Bonus")
                    }
                    
                    ButtonComponent(action: {
                        AuthService.logout()
                    }, text: "Se Déconnecter")
                    
                }
            }
            
        }.padding([.vertical], 32).padding([.horizontal], 20)
            .onAppear {
                Task {
                    player = await GameService.getPlayerData() ?? player
                    game = await GameService.getGameData() ?? game
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
