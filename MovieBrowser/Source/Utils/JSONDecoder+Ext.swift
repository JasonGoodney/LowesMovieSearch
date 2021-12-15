//
//  JSONDecoder+Ext.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/14/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension JSONDecoder {
    convenience init(keyDecodingStrategy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
