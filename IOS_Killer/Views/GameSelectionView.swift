//
//  GameSelectionView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 15/05/2023.
//

import SwiftUI

struct GameSelectionView: View {
    @State var games: [GameHasPlayer] = []
    @State private var selection: GameHasPlayer? = nil

    var body: some View {
        Group {
            if selection != nil {
                GameSelectionView_WithGames(games: games, selection: selection!)
            } else {
                GameSelectionView_WithoutGames()
            }
        }.padding(20)
        .task {
            guard let userData = await UserService.getUserData() else { return }

            games = userData.games.as_player
            selection = games.count > 0 ? games[0] : nil
        }
    }
    
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}

struct GameSelectionView_WithGames: View {
    @State var games: [GameHasPlayer]
    @State var selection: GameHasPlayer

    var body: some View {
        ScrollView {
            Text("Avec Quelle partie voulez vous jouer")
                .font(Font.custom("Staatliches-Regular", size: 48))
                .foregroundColor(.white)

            ForEach(games) { game in
                
                GameSelectorComponent(game: game, isActive: game.is_alive) {
                    selection = game
                    UserDefaults.standard.set(selection.id, forKey: "game_id")
                }
                
            }.padding([.horizontal], 20)
                .padding([.vertical], 5)
        }
        
    }
}

struct GameSelectionView_WithoutGames: View {
    var body: some View {
        Text("Vous n'êtes dans aucune partie !")
            .font(Font.custom("Staatliches-Regular", size: 48))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
              .frame(maxWidth: .infinity, alignment: .center)
        
        ButtonComponent(action: AuthService.logout, text: "Se Déconnecter")
    }
}
