//
//  CustomButtonComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 16/05/2023.
//

import SwiftUI

struct CustomButtonComponent: View {
    let text:String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .frame(maxWidth: .infinity)
        }).buttonStyle(.borderedProminent)
    }
}

struct CustomButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonComponent(text:"hello") {
            print("ok")
        }
    }
}
