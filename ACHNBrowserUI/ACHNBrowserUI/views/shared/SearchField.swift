//
//  SearchField.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var placeholder: LocalizedStringKey = "Search..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $searchText)
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.subheadline).foregroundColor(.red)
                }.buttonStyle(BorderlessButtonStyle())
            }
        }
        .foregroundColor(Color.text)
        .padding(8)
        .background(Color.dialogue)
        .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(2)
        .listRowBackground(Color.dialogueReverse)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SearchField(searchText: .constant(""),
                            placeholder: "test")
                Text("An item")
            }
        }
    }
}
