//
//  Cases.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import Foundation

extension Double {
    var cases : String {
        if self > 100000{
            let value = self/1000000
            var string = String(format: "%.2f", [value])
            return string + " M"
        } else if self > 1000 {
            let value = self/1000
            var string = String(Int(value))
            return string + " K"
        } else {
            return String(Int(self))
        }
    }
}
