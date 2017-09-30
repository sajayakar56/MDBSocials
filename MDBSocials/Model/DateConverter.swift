//
//  DateConverter.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/29/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import Foundation

class DateConverter {
    class func stringToDate(s: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if let date = dateFormatter.date(from: s) {
            return date
        } else {
            return Date()
        }
    }
}
