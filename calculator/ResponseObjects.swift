//
//  ResponseObjects.swift
//  calculator
//
//  Created by Andrey Kurganov on 6/29/20.
//  Copyright © 2020 Andrey Kurganov. All rights reserved.
//

import SwiftUI

struct ResponseSaleTax: Decodable {
    let totalRate: Double
    let rates: [Rate]
}

struct Rate: Decodable {
    let rate: Double
    let name: String
    let type: String
}
