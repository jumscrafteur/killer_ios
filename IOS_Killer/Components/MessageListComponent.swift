//
//  MessageListComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 10/05/2023.
//

import SwiftUI

struct MessageListComponent: View {
    let messages: [Message]
    var body: some View {
        
                GeometryReader { proxy in
                    let offset = proxy.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                }
                
                Text("actualités")
                    .font(Font.custom("Staatliches-Regular", size: 48))
                    .foregroundColor(.white)

                
                VStack(spacing: 20) {
                    ForEach(messages) { message in
                        
                           MessageComponent(message: message)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal], 20)
                }

            
        
    }
}

struct MessageListComponent_Previews: PreviewProvider {
    static var previews: some View {
        MessageListComponent(messages: [])
    }
}
