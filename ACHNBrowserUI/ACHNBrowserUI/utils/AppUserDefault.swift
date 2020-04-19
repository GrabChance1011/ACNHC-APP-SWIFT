//
//  AppUserDefault.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 19/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation

public struct AppUserDefaults {
    @UserDefault("emisphere", defaultValue: "north")
    public static var emisphere: String
}

