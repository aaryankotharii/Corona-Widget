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
    
    @ObservedObject var coronaStore = SessionStore()
    
    func timeline(with context: Context, completion: @escaping (Timeline<CoronaData>) -> ()) {
        
        var entries: [CoronaData] = []
        
        let refresh = Calendar.current.date(byAdding: .second, value: 20, to: Date()) ?? Date()
        coronaStore.fetch{ corona in
            entries.append(CoronaData(corona))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            
            print("update")
            
            completion(timeline)
        }
    }

    
    func snapshot(with context: Context, completion: @escaping (CoronaData) -> ()) {
        coronaStore.fetch{ corona in
            completion(CoronaData(corona))
        }
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

struct largeWidget : View {
    var data : CoronaData
    var body : some View {
        VStack{
            HStack{
                Image("global")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all,20)
            }
            VStack{
                countStack(total: data.Global.TotalConfirmed, new: data.Global.NewConfirmed, color: .coronapink, name: "confirmed")
                countStack(total: data.Global.TotalRecovered, new: data.Global.NewRecovered, color: .coronagreen, name: "recovered")
                countStack(total: data.Global.TotalDeaths, new: data.Global.NewDeaths, color: .coronagrey, name: "deaths")
                countStack(total: totalActive(), new: 0.0, color: .coronayellow, name: "active",isActive:true)
            }
            Spacer()
            ForEach(topTen(), id:\.self) { emoji in
                HStack{
                Text(emoji)
                }
            }
        }
    }
    
    func totalActive()-> Double{
        return data.Global.TotalConfirmed - data.Global.TotalDeaths - data.Global.TotalRecovered
    }
    
    func topTen()->[String]{
    let sorted = data.Countries.sorted { $0.TotalConfirmed >  $1.TotalConfirmed}
        let final = Array(sorted.prefix(10)).map { $0.CountryCode }
        let emojis = final.map { convertToEmoji(str: $0)}
        print(emojis)
     return emojis
    }
}

struct countStack : View {
    let total : Double
    let new : Double
    let color : Color
    let name : String
    var isActive = false
    var body: some View {
        HStack{
            Text("Total \(name) : \(Int(total))")
            Text(isActive ? "" : " + \(Int(new))").foregroundColor(color)
        }
    }
}

@main
struct Config : Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Widget", provider: DataProvider(), placeholder: Placeholder()) { data in
            WidgetView(data: data)
        }
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
        .description(Text("Current Time widget"))
    }
}


//struct Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetView(data: CountryModel(date: Date(), total: 100, active: 30, deaths: 20, recovered: 50,name: "India", code: "IN",emoji: "🇮🇳", global: Global()))
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//    }
//}

