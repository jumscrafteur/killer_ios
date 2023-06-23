//
//  Api.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import Foundation

struct ApiResponse<T> {
    let code: Int
    let data: T
    let message: String
}

struct Feed {
    let messages: [Message]
}

struct Message: Codable, Identifiable {
    let id: Int
    let type: Int
    let title: String
    let body: String
    let date: String
    
}


class Api : ObservableObject {
    let baseUrl = "https://killer.zalax.xyz"
    func getMessages() {
        guard let url = URL(string: baseUrl + "/game/jyd9QkBeYW/feed?offset=0&limit=20") else {
            print("Invalid url...")
            return
        }
        
        print(url)
    }
}
