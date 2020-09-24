//
//  Cases.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import Foundation

// MARK: - EXETNSION SHORTEN NUMBER

extension Double {
    var cases : String {
        if self > 100000{
            let value = self/1000000
            let string = String(format: "%.2f", value)
            print("value2",string)
            return string + " M"
        } else if self > 1000 {
            let value = self/1000
            let string = String(Int(value))
            return string + " K"
        } else {
            return String(Int(self))
        }
    }
}
