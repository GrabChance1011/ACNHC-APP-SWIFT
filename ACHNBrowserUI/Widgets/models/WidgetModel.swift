//
//  WidgetModel.swift
//  WidgetsExtension
//
//  Created by Thomas Ricouard on 23/06/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import WidgetKit
import Backend
import UIKit

struct WidgetModel: TimelineEntry {
    public let date: Date
    public let availableFishes: [Item]?
    public let villager: Villager
    public var villagerImage: UIImage?
}

