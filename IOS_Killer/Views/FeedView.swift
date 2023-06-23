//
//  Feed.swift
//  IOS_Killer
//
//  Created by Hugo Sansane on 07/05/2023.
//

import SwiftUI

struct FeedView: View {
    @State var feed = Feed(messages: [])
    @State var oldPositionValue: CGFloat = 0
    
    @State var lastMax:Double = 0
    @State var refreshOpacity:Double = 0

    var body: some View {
        ZStack(alignment: .top) {
            Image(systemName: "arrow.clockwise.circle.fill")
                .resizable()
                .rotationEffect(.degrees(360 * refreshOpacity))
                .frame(width: 30, height: 30)
                .opacity(refreshOpacity)
                .offset(y:10)
            
            ScrollView(showsIndicators: true) {
                MessageListComponent(messages: feed.messages)
            }.coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    lastMax = .maximum(lastMax, value)
                    
                    if oldPositionValue - value > 0 && value == 0 && lastMax>=70 {
                        Task {
                            feed = await GameService.getFeed()!
                        }
                        lastMax = 0
                    }
                    oldPositionValue = value
                    
                    refreshOpacity = .maximum(0, .minimum(1, (oldPositionValue-20)/50))
                }.task {
                    self.feed = await GameService.getFeed() ?? Feed(messages: [])
                }

        }
        
        
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feed: Feed(messages: [
            Message(id: 1, title: "Bienvenue sur notre application", body: "Nous sommes heureux de vous accueillir sur notre application.", type: 0, date: "2023-05-09"),
            Message(id: 2, title: "Promotion exceptionnelle", body: "Profitez de notre promotion exceptionnelle de fin d'année !", type: 1, date: "2023-05-08"),
            Message(id: 3, title: "Maintenance planifiée", body: "Notre site web sera temporairement hors ligne pour une maintenance planifiée demain à partir de 22h.", type: 2, date: "2023-05-07"),
            Message(id: 4, title: "Nouvelle version de l'application disponible", body: "Une nouvelle version de notre application est maintenant disponible sur l'App Store. N'oubliez pas de la mettre à jour !", type: 0, date: "2023-05-06"),
            Message(id: 5, title: "Remboursement de commande", body: "Nous avons le plaisir de vous informer que le remboursement de votre commande a été effectué avec succès.", type: 1, date: "2023-05-05"),
            Message(id: 6, title: "Problème technique résolu", body: "Le problème technique qui affectait notre site web a été résolu. Nous sommes désolés pour les désagréments causés.", type: 2, date: "2023-05-04"),
            Message(id: 7, title: "Offre spéciale pour nos clients fidèles", body: "Nous avons une offre spéciale pour nos clients fidèles. Vérifiez votre boîte de réception pour plus d'informations !", type: 1, date: "2023-05-03"),
            Message(id: 8, title: "Mise à jour importante de sécurité", body: "Une mise à jour importante de sécurité a été déployée sur notre application. Veuillez mettre à jour dès que possible.", type: 0, date: "2023-05-02"),
            Message(id: 9, title: "Maintenance non planifiée", body: "Notre site web est actuellement hors ligne en raison d'une maintenance non planifiée. Nous travaillons à résoudre le problème le plus rapidement possible.", type: 2, date: "2023-05-01"),
            Message(id: 10, title: "Changements dans notre politique de confidentialité", body: "Nous avons apporté des changements à notre politique de confidentialité. Veuillez la lire attentivement avant de continuer à utiliser notre application.", type: 0, date: "2023-04-30"),
            Message(id: 11, title: "Problème de livraison", body: "Nous avons rencontré un problème avec la livraison de votre commande. Nous travaillons à résoudre le problème et nous vous tiendrons informé dès que possible.", type: 1, date: "2023-04-29"),
        ]))
    }
}
