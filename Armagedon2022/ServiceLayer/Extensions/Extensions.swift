//
//  Extensions.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 27.04.2022.
//

import Foundation

extension String {
    func getFormatName() -> String {
        let pattern = "[^A-Za-z0-9 ]+"
        let resultName = self.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
        return resultName
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateDefault = dateFormatter.date(from:self)
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        guard dateDefault != nil else { return "" }
        let formatDate = dateFormatter.string(from: dateDefault!)
        return formatDate
    }
    
    func getFormattedDistance() -> String {
        let distance = NSString(string: self)
        let result = String(Int(distance.doubleValue).formattedWithSeparator)
        return result
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Date {
    func getFormattedDateToLoad() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
}


