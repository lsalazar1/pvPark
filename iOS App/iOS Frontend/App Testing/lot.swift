//
//  lot.swift
//  App Testing
//
//  Created by Rene Ouoba on 2/27/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import Foundation

struct lot: Codable {
    var lotName: String = ""
    var availableSpots: Int = 0
    var sensors: [sensor]
}
