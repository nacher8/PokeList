//
//  TestNetworkResponse.swift
//  PokeListTests
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation

enum TestNetworkResponse {
    case success(Any?)
    case failure(Error)
}

struct MockError: Error {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
}
