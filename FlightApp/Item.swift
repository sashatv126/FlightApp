//
//  Item.swift
//  FlightApp
//
//  Created by Александр Александрович on 19.10.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
