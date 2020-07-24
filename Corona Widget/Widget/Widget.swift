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
            let entryData = CountryModel(date: Date(), total: total , active: active, deaths: deaths , recovered: recovered , name: country.Country, code: country.CountryCode.lowercased(), emoji: "🇮🇳")
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
            let entryData = CountryModel(date: Date(), total: total , active: active, deaths: deaths , recovered: recovered , name: country.Country, code: country.CountryCode.lowercased(), emoji: "🇮🇳")
            
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
                smallWidget(data: data)
            case .systemMedium:
                mediumWidget(data: data)
            case .systemLarge:
                largeWidget(data: data)
            @unknown default:
                smallWidget(data: data)
            }
        }
    }
}


struct smallWidget : View {
    var data : CountryModel
    var body : some View {
        VStack{
            HStack{
                Spacer()
                Text(data.emoji)
                Text(data.name)
                Spacer()
            }.font(.headline)
            .foregroundColor(.white)
            .padding(.top, 10)
            .padding(.all, 10)
            .background(Color.pink)
            VStack(alignment:.leading){
                smallWidgetBlock(type: .total, count: data.total, color: .coronapink)
                smallWidgetBlock(type: .recovered, count: data.recovered, color: .coronagreen)
                smallWidgetBlock(type: .deaths, count: data.deaths, color: .coronagrey)
                smallWidgetBlock(type: .active, count: data.active, color: .coronayellow)

            }.padding(.bottom, 15)
            Spacer()
        }
    }
}

struct smallWidgetBlock : View {
    var type : coronaType
    var count : Double
    var color : Color
    var body: some View {
        HStack {
            Image(type.image)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
            
            Text(type.title)
                .minimumScaleFactor(0.5)
                .font(.system(size: 15))
                .lineLimit(1)
                .layoutPriority(1)
            Text(count.cases)
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .layoutPriority(1)
                .foregroundColor(color)
        }
    }
}

struct mediumWidget : View {
    var data : CountryModel
    var body : some View {
        HStack{
            PieChart(pieChartData: PieChartData(data: [data.active, data.deaths, data.recovered],colors:[.coronagreen,.coronagrey,.coronayellow]))
                .padding(.all,25)
            Spacer()
            VStack(alignment:.leading){
                HStack{
                    Text(data.emoji)
                    Text(data.name)
                    Spacer()
                }.font(.system(size: 35))
                .foregroundColor(.black)
                .padding(.top,20)
                VStack(alignment:.leading) {
                    Text("Total: "+data.total.cases)
                        .foregroundColor(.coronapink)
                    Text("Recovered: "+data.recovered.cases)
                        .foregroundColor(.coronagreen)
                    Text("Deaths: "+data.deaths.cases)
                        .foregroundColor(.coronagrey)
                    Text("Active: "+data.active.cases)
                        .foregroundColor(.coronayellow)
                }
            }.padding(.bottom, 15)
        }
    }
}

struct largeWidget : View {
    var data : CountryModel
    var body : some View {
        HStack{
          MapView(coordinate: fetchCoordinates())
        }
    }
    
    func fetchCoordinates()->CLLocationCoordinate2D{
        let cc = data.code
        let coord = countryCoord[cc]
        let lat = coord![0]
        let long = coord![1]
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        return coordinates
    }
}

struct GraphView : View {
    var country : CountryModel
    var body: some View {
        GeometryReader(content: { geometry in
            VStack{
                BarLine(end: geometry.size.width * 0.75, value: country.total, color: .coronapink)
                BarLine(end: geometry.size.width * recoveredpercent(), value: country.active, color: .coronagreen)
                BarLine(end: geometry.size.width * deathPercent(), value: country.deaths, color: .coronagrey)
                BarLine(end: geometry.size.width * activepercent(), value: country.active, color: .coronayellow)
            }
        })
    }
    func activepercent()->CGFloat {
        print(CGFloat(country.active/country.total) * 0.75)
        return CGFloat(country.active/country.total) * 0.75
    }
    
    func deathPercent()->CGFloat {
        return CGFloat(country.deaths/country.total) * 0.75
    }
    
    func recoveredpercent()->CGFloat {
        return CGFloat(country.recovered/country.total) * 0.75
    }
}


struct BarLine : View {
    var end : CGFloat
    var value : Double
    var color : Color
    var body: some View {
        HStack{
            Path { path in
                path.move(to: CGPoint(x: 0, y: 20))
                path.addLine(to: CGPoint(x: Int(end), y: 20))
            }
            .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .animation(.easeIn)
            .onTapGesture {
                print(end)
            }
            Text("\(Int(value))")
                .foregroundColor(color)
        }
    }
}

struct Placeholder : View{
    var body : some View {
        Text("YOLO")
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


enum coronaType {
    case total
    case active
    case deaths
    case recovered
    
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
    
    var title : String {
        switch self {
        case .total:
            return "Total"
        case .active:
            return "Active"
        case .deaths:
            return "Deaths"
        case .recovered:
            return "Recovered"
        }
    }
    
    
}
