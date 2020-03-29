//
//  Dateformatter.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation



class LabelTextFormatter {
    
    static let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 1
        nf.generatesDecimalNumbers = true
        return nf
    }()
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    static let printOutDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    static func formatReleaseDate(_ dateString: String) -> String {
        if let date = LabelTextFormatter.dateFormatter.date(from: dateString) {
            return LabelTextFormatter.printOutDateFormatter.string(from: date)
        }
        return ""
    }
    
    static func formatVoteCount(_ count: Int) -> String {
        switch count {
        case 0...999:
            return LabelTextFormatter.numberFormatter.string(from: NSNumber(value: count))!
            
        case 1000...999999:
            return LabelTextFormatter.numberFormatter.string(from: NSNumber(value: Double(count) / 1000))! + "K"
            
        default:
            return LabelTextFormatter.numberFormatter.string(from: NSNumber(value: Double(count) / 1000000))! + "M"
            
        }

    }
    
    static func formatVoteAverage(_ count: Double) -> String {
        if let c = LabelTextFormatter.numberFormatter.string(from: NSNumber(value: count)) {
            return c
        }
        return ""
    }
}
