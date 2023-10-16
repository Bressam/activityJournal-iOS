//
//  Calendar+Extensions.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation

extension Calendar {
    func makeDate(year: Int, month: Int, day: Int = 1, hr: Int = 0, min: Int = 0, sec: Int = 0) -> Date {
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return self.date(from: components)!
    }
}
