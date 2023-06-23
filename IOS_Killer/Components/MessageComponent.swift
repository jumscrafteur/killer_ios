//
//  MessageComponent.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 10/05/2023.
//

import SwiftUI

struct MessageComponent: View {
    let message: Message
    @State var formatter: RelativeDateTimeFormatter
    
    init(message: Message) {
        self.message = message
        self.formatter = RelativeDateTimeFormatter()
        
        formatter.locale = Locale(identifier: "fr-FR")
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // formatter.unitsStyle = .spellOut
    }
    
    var body: some View {
        VStack(spacing: 4) {
            //let exampleDate = formatter.date(from: "2022-01-31T02:22:40Z")
            
            // Text(formatter.localizedString(for: exampleDate, relativeTo: Date.now))
            Text(message.date)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(message.title)
                    .font(Font.custom("Staatliches-Regular", size: 24))
                    .frame(maxWidth: .infinity)
                Text(message.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.foreground, lineWidth: 4)
            ).background(Color(red: 0,green: 0, blue: 0,opacity: 0.5))
        }
    }
}

struct MessageComponent_Previews: PreviewProvider {
    static var previews: some View {
        MessageComponent(message: Message(id: 1, title: "Bienvenue sur notre application", body: "Nous sommes heureux de vous accueillir sur notre application.", type: 0, date: "2023-05-09"))
    }
}
