//
//  Dateformatter.swift
//  Newvies
//
//  Created by Jay Jac on 3/17/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation



class LabelTextFormatter {
    
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
}
