//
//  Widget.swift
//  Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import WidgetKit
import SwiftUI
import Intents
import MapKit

struct DataProvider : TimelineProvider {
    
    func placeholder(in context: Context) -> CoronaData {
        
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CoronaData) -> Void) {
        coronaStore.fetch{ corona in
            completion(CoronaData(corona))
        }
    }
    
    
    @ObservedObject var coronaStore = SessionStore()
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CoronaData>) -> ()) {
        
        var entries: [CoronaData] = []
        
        let refresh = Calendar.current.date(byAdding: .hour, value: 10, to: Date()) ?? Date()
        coronaStore.fetch{ corona in
            entries.append(CoronaData(corona))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        }
    }
    
    
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
        
        var Country : Countries{
            let country = CurrentCountry.county.rawValue
            let countries = data.Countries
            let mycountry = countries.filter { $0.CountryCode == country}
            return mycountry.first!
        }
    }


//@main
//struct Config : Widget {
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: "Widget", provider: DataProvider()) { (<#TimelineEntry#>) -> _ in
//            <#code#>
//        }
//        StaticConfiguration(kind: "Widget", provider: DataProvider()) { data in
//            WidgetView(data: data)
//        }
//        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
//        .description(Text("Current Time widget"))
//    }
//}
