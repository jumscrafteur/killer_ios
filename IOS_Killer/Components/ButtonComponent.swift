//
//  ButtonComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 19/06/2023.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundStyle(Color.background)
            .cornerRadius(8)
            .font(.system(size: 24))
    }
}

struct ButtonComponent: View {
    let action: (() -> Void)
    let text: String
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .frame(maxWidth: .infinity)
        }).buttonStyle(BlueButton())
    }
}
