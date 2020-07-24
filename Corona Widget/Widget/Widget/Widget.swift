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

struct CountryModel : TimelineEntry {
    var date: Date
    var total : Double
    var active : Double
    var deaths : Double
    var recovered : Double
    var name : String
    var code : String
    var emoji : String
}

struct DataProvider : TimelineProvider {
    
    @ObservedObject var coronaStore = SessionStore()
    
    func timeline(with context: Context, completion: @escaping (Timeline<CountryModel>) -> ()) {
        
        var entries: [CountryModel] = []
        
        let refresh = Calendar.current.date(byAdding: .second, value: 20, to: Date()) ?? Date()
        coronaStore.fetch{ corona in
            let country = getCountryDetails(corona)
            let total = country.TotalConfirmed
            let deaths = country.TotalDeaths
            let recovered = country.TotalRecovered
            let active = total - deaths - recovered
            let emoji = convertToEmoji(str: country.CountryCode)
            let entryData = CountryModel.init(date: Date(), total: total , active: active, deaths: deaths , recovered: recovered , name: country.Country, code: country.CountryCode.lowercased(), emoji: emoji)
            entries.append(entryData)
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            
            print("update")
            
            completion(timeline)
        }
    }
    
    func getCountryDetails(_ corona : Corona)->Countries{
        let country = CurrentCountry.county.rawValue
        let countries = corona.Countries
        let mycountry = countries.filter { $0.CountryCode == country}
        return mycountry.first!
    }
    
    func snapshot(with context: Context, completion: @escaping (CountryModel) -> ()) {
        coronaStore.fetch{ corona in
            let country = getCountryDetails(corona)
            let total = country.TotalConfirmed
            let deaths = country.TotalDeaths
            let recovered = country.TotalRecovered
            let active = total - deaths - recovered
            let emoji = convertToEmoji(str: country.CountryCode)

            let entryData = CountryModel.init(date: Date(), total: total , active: active, deaths: deaths , recovered: recovered , name: country.Country, code: country.CountryCode.lowercased(), emoji: emoji)
            
            completion(entryData)
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
                smallWidget(data: CountryData(data))
            case .systemMedium:
                mediumWidget(data: CountryData(data))
            case .systemLarge:
                largeWidget(data: CountryData(data))
            @unknown default:
                smallWidget(data: CountryData(data))
            }
        }
    }
}

struct largeWidget : View {
    var data : CountryData
    var body : some View {
        VStack{
            HStack{
                Image("global")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all,20)
            }
            VStack{
                Text("Total cases: \(data.)")
            }
            Spacer()
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


struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(data: CountryModel(date: Date(), total: 100, active: 30, deaths: 20, recovered: 50,name: "India", code: "IN",emoji: "🇮🇳"))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

extension CountryData {
    init(_ data : CountryModel){
        self.date =  Date()
        self.total = data.total
        self.active = data.active
        self.deaths = data.deaths
        self.recovered = data.recovered
        self.name = data.name
        self.code = data.code
        self.emoji = data.emoji
    }
}
