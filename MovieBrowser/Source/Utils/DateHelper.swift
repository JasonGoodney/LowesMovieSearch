//
//  DateHelper.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/12/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct DateHelper {
    static func format(_ dateString: String, from fromFormat: String, to toFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale.init(identifier: "en_US")

        let date = dateFormatter.date(from: dateString)!

        dateFormatter.dateFormat = toFormat//"MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
