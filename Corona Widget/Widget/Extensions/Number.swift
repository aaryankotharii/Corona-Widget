//
//  Number.swift
//  Corona Widget
//
//  Created by Ravi on 02/10/20.
//

import Foundation

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self)) ?? "\(Int(self))"
    }
}
