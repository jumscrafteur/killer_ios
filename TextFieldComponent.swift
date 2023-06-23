//
//  TextFieldComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 19/06/2023.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


struct CustomInputStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .font(.system(size: 24))
            .foregroundColor(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 4)
            )
            
    }
}

struct TextFieldComponent: View {
    let placeholder: String
    @Binding var  text: String
    
    var body: some View {
        TextField("", text: self.$text)
            .textFieldStyle(CustomInputStyle())
            .autocorrectionDisabled(true)
            .placeholder(when: text.isEmpty) {
                HStack {
                    Text(placeholder)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                }.padding(.horizontal, 16)
                
            }
        
    }
}

