//
//  RequestManager.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 15/05/2023.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let code: Int
    let data: T?
    let message: String
}

struct JWTData: Codable {
    let sub: Int
    let exp: Int
}

enum RequestErrors: Error {
    case ForbidenAccess(String)
    case InternalServerError(String)
    case UnknownRequestError(Int, String)
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}

let BASE_URL = URL(string: "https://killer.zalax.xyz")

class RequestManager {
    class func post<T: Codable>(route: String, params: [String: Any], responseType: T.Type) async throws -> T? {
        var token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        if (route != "auth/refresh" && UserDefaults.standard.string(forKey: "token") != "" && AuthService.isTokenExpired(token: token)) {
                print("refresh token")
                AuthService.refreshToken()
            
            
            token = UserDefaults.standard.string(forKey: "token") ?? ""
        }
        
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string: route, relativeTo: BASE_URL)!
        
        print(url)
        
        print(params)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) as Data
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
        
        switch response.code {
        case 200:
            return response.data ?? nil
        case 403:
            throw RequestErrors.ForbidenAccess(response.message)
        case 500:
            throw RequestErrors.InternalServerError(response.message)
        default:
            throw RequestErrors.UnknownRequestError(response.code, response.message)
        }
    }
    
    class func get<T: Codable>(route: String, params: [String: String], responseType: T.Type) async throws -> T {
        var token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        if (UserDefaults.standard.string(forKey: "token") != "" && AuthService.isTokenExpired(token: token)) {
                print("refresh token")
                AuthService.refreshToken()
            
            
            token = UserDefaults.standard.string(forKey: "token") ?? ""
        }
        
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        var url = URL(string: route, relativeTo: BASE_URL)!
        
        for (key, value) in params {
            url = url.appending(key, value: value)
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
        
        switch response.code {
        case 200:
            return response.data!
        case 403:
            AuthService.logout()
            throw RequestErrors.ForbidenAccess(response.message)
        case 500:
            throw RequestErrors.InternalServerError(response.message)
        default:
            AuthService.logout()
            throw RequestErrors.UnknownRequestError(response.code, response.message)
        }

    }
    
}
