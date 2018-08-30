//
//  Structure.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 8/30/18.
//  Copyright © 2018 CoPilot Creative. All rights reserved.
//

import Foundation

/* General Result */

struct BlankFeedResult: Codable {
    
    let status: Bool?
    let error: String?
    
    enum CodingKeys: CodingKey {
        case status
        case error
    }
    
}
