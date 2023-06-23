//
//  mainView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 08/05/2023.
//

import SwiftUI

struct mainView: View {    
    var body: some View {
        TabView {
            
            FeedView()
                .tabItem {
                    //Image("Feed")
                    Label("Feed", image: "Feed")
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
            
            KillView()
                .tabItem {
                    Label("Kill", image: "Contract")
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
                
            
            ProfileView()
               .tabItem {
                   Label("Profile", image: "Info")
               }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)

        }.onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = .black
            
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            let itemAppearance = tabBarAppearance.stackedLayoutAppearance
            
            itemAppearance.normal.iconColor = .gray
            itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            
            itemAppearance.selected.iconColor = .white
            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.white)]
            
        }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
