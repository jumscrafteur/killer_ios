//
//  IOS_KillerApp.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import SwiftUI

@main
struct IOS_KillerApp: App {
    var body: some Scene {
        
        WindowGroup {
                ContentView()
                .onOpenURL { url in
                    print("URL : \(url)")
                }
        }
    }
    
}

