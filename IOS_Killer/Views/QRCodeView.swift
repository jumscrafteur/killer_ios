//
//  QRCodeView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 16/05/2023.
//

import SwiftUI

struct QRCodeView: View {
    let player: PlayerExtended
    var body: some View {
        /*if !player.is_alive {
            Text("Vous êtes mort")
        } else if player.contract != nil {
            Text("Vous êtes toujours en vie")
        } else {
            Text("La partie n'a pas commencée")
        }*/

        if player.private_key != nil {
            QRCodeComponent(content: player.private_key!)
        } else {
            Text("Vous devez activer votre carte pour afficher votre QR Code")
                .multilineTextAlignment(.center)
        }
    }
}
