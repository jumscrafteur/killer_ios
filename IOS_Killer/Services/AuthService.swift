//
//  AuthService.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 15/05/2023.
//

import Foundation

struct LoginInfo: Codable {
    let refresh_token: String
    let token: String
}

struct RefreshedToken: Codable {
    let token: String
}

class AuthService {
    class func login(email: String, password: String) {
        Task {
            do {
                let loginInfo = try await RequestManager.post(
                    route: "auth/login",
                    params: [
                        "email": email,
                        "password": password,
                        "persistent_session": true,
                    ],
                    responseType: LoginInfo.self)
                
                UserDefaults.standard.set(loginInfo!.token, forKey: "token")
                UserDefaults.standard.set(loginInfo!.refresh_token, forKey: "refresh_token")
                
                
            } catch {
                
                print(error)
                
            }
        }
    }
    
    class func isTokenExpired(token: String) -> Bool {
        let base64EncodedDatas = token.components(separatedBy: ".")
        
        guard base64EncodedDatas.count == 3 else {
            return true
        }
        
        let base64EncodedData = base64EncodedDatas[1]
        
        guard let data = Data(base64Encoded: base64EncodedData) else {
            return true
        }
        
        guard let objectData = try? JSONDecoder().decode(JWTData.self, from: data) else {
            return true
        }
        
        print("Actual timestamp : ")
        print(Date().timeIntervalSince1970)
        print("Expiration : ")
        print(objectData.exp)
        
        return Date(timeIntervalSince1970: Double(objectData.exp)) < Date()
    }
    
    class func refreshToken() {
        Task(priority:.high) {
            do {
                let refreshedToken = try await RequestManager.post(
                    route: "auth/refresh",
                    params: [
                        "refresh_token": UserDefaults.standard.string(forKey: "refresh_token") ?? ""
                    ],
                    responseType: RefreshedToken.self)
                
                UserDefaults.standard.set(refreshedToken!.token, forKey: "token")
                
            } catch {
                
                print(error)
                
            }
        }
    }


    class func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "game_id")
    }
}
