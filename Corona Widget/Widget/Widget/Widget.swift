//
//  Widget.swift
//  Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import WidgetKit
import SwiftUI
import Intents

struct DataProvider : TimelineProvider {
    
    /// SESSION STORE IS OBSERVABLE OBJECT MADE USING COMBINE
    @ObservedObject var coronaStore = SessionStore()
    
    
    /// function to fetch covid data and display in widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<CoronaData>) -> ()) {
        
        var entries: [CoronaData] = [] /// List of entries
        
        /// Widget will refresh every `10 hours`
        let refresh = Calendar.current.date(byAdding: .hour, value: 10, to: Date()) ?? Date()
        
        /// fetching and updating data
        coronaStore.fetch{ corona in
            entries.append(CoronaData(corona))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        }
    }
    
    
    func getSnapshot(in context: Context, completion: @escaping (CoronaData) -> Void) {
        coronaStore.fetch{ corona in
            completion(CoronaData(corona))
        }
    }
    
    /// `Placeholder`Widget before the data loads from getTimeline
    func placeholder(in context: Context) -> CoronaData {
        return CoronaData(Corona(Global: Global(NewConfirmed: 0, TotalConfirmed: 0, NewDeaths: 0, TotalDeaths: 0, NewRecovered: 0, TotalRecovered: 0), Countries: [Countries(Country: "India", CountryCode: "IN", Slug: "IN", NewConfirmed: 0, TotalConfirmed: 0, NewDeaths: 0, TotalDeaths: 0, NewRecovered: 0, TotalRecovered: 0, Date: "DATE")]))
    }
    
}

// WIDGET with 3 cases
/// small
/// medium
/// large
struct WidgetView : View{
    var data : DataProvider.Entry
    @Environment(\.widgetFamily) private var family
    var body : some View {
        Group {
            switch family {
            case .systemSmall:
                smallWidget(data: Country)
            case .systemMedium:
                mediumWidget(data: Country)
            case .systemLarge:
                largeWidget(data: data)
            @unknown default:
                smallWidget(data: Country)
            }
        }
    }
    
    /// get country details of selected country
    var Country : Countries{
        let country = CurrentCountry.county.rawValue
        let countries = data.Countries
        let mycountry = countries.filter { $0.CountryCode == country}
        return mycountry.first!
    }
}


// MARK: - ACTAUL WIDGET
@main /// swiftui 2.0 stuff
struct Config : Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Widget", provider: DataProvider()) { data in
            WidgetView(data: data)
        }
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
        .description(Text("Current Time widget"))
    }
}
