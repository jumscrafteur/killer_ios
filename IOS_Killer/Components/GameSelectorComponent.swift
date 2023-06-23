//
//  GameSelectorComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 20/06/2023.
//

import SwiftUI

struct GameSelectorComponent: View {
    let game: GameHasPlayer
    let isActive: Bool
    let action: (() -> Void)
    
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 27)
            
            Spacer()
            
            Text(game.name)
                .tag(game.id)
                .foregroundColor(.white)
                .font(Font.headline.weight(isActive ? .bold : .regular))

            Spacer()
            
            if (isActive) {
                AnimatedImage(imageName: "Beating_Heart", animationDuration: 39).frame(height: 27)
            } else {
                Image("Beating_Heart_0").resizable().scaledToFit().frame(height: 27).grayscale(1)
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.foreground, lineWidth: isActive ? 4 : 2)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                action()
            }
            .background(
                isActive ?
                Color(red: 0,green: 0, blue: 0,opacity: 0.5) :
                Color(red: 0,green: 0, blue: 0,opacity: 0.0)
                
            )
    }
}
