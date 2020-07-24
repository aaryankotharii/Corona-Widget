//
//  CoronaType.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import Foundation

// MARK: Type of available data
/// `Four cases:- `
///     TOTAL
///     ACTIVE
///     DEATHS
///     RECOVERED

enum coronaType : String {
    case total = "Total"
    case active = "Active"
    case deaths = "Deaths"
    case recovered = "Recovered"
    
    /// Name of icon in `Assets.xcassets`
    var image : String {
        switch self {
        case .total:
            return "virus"
        case .active:
            return "bolt"
        case .deaths:
            return "coffin"
        case .recovered:
            return "cross"
        }
    }
}

///END
