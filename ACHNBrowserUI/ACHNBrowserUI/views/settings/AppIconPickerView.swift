//
//  AppIconPickerView.swift
//  ACHNBrowserUI
//
//  Created by Matt Bonney on 4/25/20.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

// Custom icon naming convention is {{ style }}-{{ color }}.
struct AppIcon {
    enum Style: String, CaseIterable {
        case round
        case roundAlt = "round-alt"
        case simple
        case bookmark
    }
    
    enum Color: String, CaseIterable {
        case blue
        case blueberry
        case cactus
        case cocoa
        case gold
        case lime
        case mint
        case orange
        case pink
        case sky
    }
    
    let style: AppIcon.Style
    let color: AppIcon.Color
}

struct AppIconPickerView: View {
    var body: some View {
        List {
            ForEach(AppIcon.Color.allCases, id: \.self) { color in
                self.makeRow(for: color)
            }
        }
    }
    
    func makeRow(for color: AppIcon.Color) -> some View {
        HStack {
            ForEach(AppIcon.Style.allCases, id: \.self) { style in
                Image("\(style.rawValue)-\(color.rawValue)")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .mask(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical)
    }
}

struct AppIconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconPickerView()
    }
}
