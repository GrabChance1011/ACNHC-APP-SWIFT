//
//  VillagerRowView.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 17/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct VillagerRowView: View {
    @EnvironmentObject private var collection: UserCollection
    
    let villager: Villager
    
    var body: some View {
        HStack {
            Button(action: {
                let added =  self.collection.toggleVillager(villager: self.villager)
                FeedbackGenerator.shared.triggerNotification(type: added ? .success : .warning)
            }) {
                Image(systemName: self.collection.villagers.contains(self.villager) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }.buttonStyle(BorderlessButtonStyle())
            ItemImage(path: ACNHApiService.BASE_URL.absoluteString +
                ACNHApiService.Endpoint.villagerIcon(id: villager.id).path(),
                      size: 50)
            Text(villager.name["name-en"] ?? "")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.text)
        }
    }
}
