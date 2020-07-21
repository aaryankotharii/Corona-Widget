//
//  Widget.swift
//  Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import WidgetKit
import SwiftUI
import Intents

struct CountryModel : TimelineEntry {
    var date: Date
    var total : Int
    var active : Int
    var deaths : Int
    var recovered : Int
}

struct DataProvider : TimelineProvider {
    func timeline(with context: Context, completion: @escaping (Timeline<CountryModel>) -> ()) {
        //TODO
    }
    
    func snapshot(with context: Context, completion: @escaping (CountryModel) -> ()) {
        // TODO
    }
}
