//
//  Structure.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 5/21/18.
//  Copyright © 2018 Ironbite Systems. All rights reserved.
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
