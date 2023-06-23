//
//  SecureFieldComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 19/06/2023.
//

import SwiftUI

struct SecureFieldComponent: View {
    let placeholder: String
    @Binding var  text: String
    
    var body: some View {
        SecureField("", text: self.$text)
            .textFieldStyle(CustomInputStyle())
            .autocorrectionDisabled(true)
            .placeholder(when: text.isEmpty) {
                HStack {
                    Text(placeholder)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }.padding(.horizontal, 16)
                
            }
        
    }
}
