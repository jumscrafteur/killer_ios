//
//  GameService.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import Foundation

struct Feed: Codable {
    let messages: [Message]
}

struct Message: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let type: Int
    let date: String
}


protocol Game: Codable, Hashable, Identifiable {
    var id: String {get}
    var name: String {get}
}

struct GameDetailed: Codable, Hashable, Identifiable {
    let id:String
    let name:String
    let status:Int
}

struct GameDetailed_players: Codable, Hashable {
    let alive:Int
    let total:Int
}

struct GameHasPlayer: Game, Hashable {
    let id: String
    let name: String
    let first_name: String
    let last_name: String
    let is_alive: Bool
}

struct GameHasStaff: Game, Hashable {
    let id: String
    let name: String
    let permission_level: Int
}


class GameService {
    class func getFeed() async -> Feed? {
        guard let game_id = UserDefaults.standard.string(forKey: "game_id") else {
            print("pas de game_id")
            return nil
        }

        
        do {
            return try await RequestManager.get(
                route: "/game/\(game_id)/feed",
                params: [:],
                responseType: Feed.self)
            
        } catch {
            print(error)
            return Feed(messages: [])
        }
        
    }
    
    class func getPlayerData() async -> PlayerExtended? {
        guard let game_id = UserDefaults.standard.string(forKey: "game_id") else {
            print("pas de game_id")
            return nil
        }
        
        do {
            return try await RequestManager.get(
                route: "/game/\(game_id)/me",
                params: [:],
                responseType: PlayerExtended.self)
            
        } catch {
            print(error)
        }
            
        return nil
    }
    
    class func getGameData() async -> GameDetailed? {
        guard let game_id = UserDefaults.standard.string(forKey: "game_id") else {
            print("pas de game_id")
            return nil
        }
        
        do {
            return try await RequestManager.get(
                route: "/game/\(game_id)",
                params: [:],
                responseType: GameDetailed.self)
            
        } catch {
            print(error)
        }
            
        return nil
    }
    
    class func kill(key: String, weaponId: Int) async -> Void {
        do {
            guard let game_id = UserDefaults.standard.string(forKey: "game_id") else {
                print("pas de game_id")
                return
            }
            
            try await RequestManager.post(
                route: "/game/\(game_id)/kill",
                params: [
                    "kill_key": key,
                    "weapon_id" : weaponId
                ],
                responseType: Int.self)
            
        } catch {
            print(error)
        }
    }
}
