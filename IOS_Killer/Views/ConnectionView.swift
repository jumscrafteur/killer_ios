//
//  ConnectionView.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 08/05/2023.
//

import SwiftUI

struct ConnectionView: View {
    @State private var email: String = ""
    @State private var password = ""
    
    var emailBinding: Binding<String> {
        return Binding(get: {
            return !email.isEmpty ? email : ""
        }, set: { newValue in
            self.email = newValue
        })
      }
    
    var passwordBinding: Binding<String> {
        return Binding(get: {
            return !password.isEmpty ? password : ""
        }, set: { newValue in
            password = newValue
        })
      }
    
    var body: some View {
        
        VStack(spacing: 48) {
            Text("SE CONNECTER")
                .font(Font.custom("Staatliches-Regular", size: 48))
                .foregroundColor(.white)
            
            Image("Login_logo").resizable().aspectRatio(contentMode: .fit)
            
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    TextFieldComponent(placeholder: "Email", text: emailBinding).autocapitalization(.none)
                    SecureFieldComponent(placeholder: "Password", text: passwordBinding)
                }
                
                ButtonComponent(action: self.login, text: "Se connecter")
            }
            
        }
        .padding(40)
            
    }
        
    
    func login() {
        print("Loging in:")
        print(self.email)
        print(self.password)
        
        AuthService.login(email: self.email, password: self.password)
    }
    
    func logout() {
        AuthService.logout()
    }
}
