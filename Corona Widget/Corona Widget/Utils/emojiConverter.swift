//
//  emojiConverter.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import Foundation

//MARK: STRING TO EMOJI CONVERTER

// function that convertes countryCode to country emoji!

func convertToEmoji(str: String) -> String {
    let lowercased = str.lowercased()
    guard lowercased.count == 2 else { return "" }
    let regionalIndicators = lowercased.unicodeScalars.map { UnicodeScalar($0.value + (0x1F1E6 - 0x61))! }
    return String(regionalIndicators.map { Character($0) })
}
