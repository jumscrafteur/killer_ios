//
//  UserService.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import Foundation

struct Games: Codable {
    let as_player: [GameHasPlayer]
    let as_staff: [GameHasStaff]
}

struct PersonalInformations: Codable, Identifiable {
    let id: Int
    let email: String
    let username: String?
    let first_name: String?
    let last_name: String?
    let games: Games
}

struct PlayerExtended: Identifiable, Codable, Hashable {
    let id:Int
    let contract: Contract?
    let first_name: String
    let last_name: String
    let is_alive: Bool
    let private_key: String?
    let score: Int
}

struct Contract: Codable, Hashable {
    let target: Player
    let weapons: [Weapon]
}

struct Player: Codable, Identifiable, Hashable {
    let first_name: String
    let id: Int
    let last_name: String
}

struct Weapon: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let points: Int
}



class UserService {
    class func getUserData() async -> PersonalInformations? {
        do {
            return try await RequestManager.get(
                route: "/user/me",
                params: [:],
                responseType: PersonalInformations.self)
            
            
        } catch {
            print(error)
        }
            
        return nil
    }
}
