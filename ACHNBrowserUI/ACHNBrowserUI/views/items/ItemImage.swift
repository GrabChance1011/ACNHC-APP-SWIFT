//
//  ItemImage.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemImage : View {
    private static let SERVICE_URL = "https://i.imgur.com/"

    let path: String?
    let size: CGFloat
    
    var body: some View {
        WebImage(url: path!.starts(with: "http") ? URL(string: path!) : URL(string: "\(Self.SERVICE_URL)\(path!).png"))
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .animation(.spring())
    }
}
