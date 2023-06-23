//
//  ContentView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("token") var token:String?
    @AppStorage("game_id") var game_id:String?
    
    var body: some View {
        VStack {
            if(token == nil) {
                ConnectionView()
            } else if(token != nil && game_id == nil) {
                GameSelectionView()
            } else if(token != nil && game_id != nil) {
                mainView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
