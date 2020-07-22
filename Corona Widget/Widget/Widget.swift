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
    var total : Double
    var active : Double
    var deaths : Double
    var recovered : Double
    var name : String
    var emoji : String
}

struct DataProvider : TimelineProvider {
    
    @ObservedObject var corona = SessionStore()
    
    func timeline(with context: Context, completion: @escaping (Timeline<CountryModel>) -> ()) {
        
        corona.fetch()
        
        let entryData = CountryModel(date: Date(), total: corona.current?.Global.TotalConfirmed ?? 1, active: 100000, deaths: corona.current?.Global.TotalDeaths ?? 1, recovered: corona.current?.Global.TotalRecovered ?? 1, name: "India", emoji: "🇮🇳")
        
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        
        
        let timeline = Timeline(entries: [entryData], policy: .after(refresh))
        
        print("update")
        
        completion(timeline)
    }
    
    func snapshot(with context: Context, completion: @escaping (CountryModel) -> ()) {
        corona.fetch()
        
        let entryData = CountryModel(date: Date(), total: corona.current?.Global.TotalConfirmed ?? 1, active: 100000, deaths: corona.current?.Global.TotalDeaths ?? 1, recovered: corona.current?.Global.TotalRecovered ?? 1, name: "India", emoji: "🇮🇳")
        
        completion(entryData)
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
                smallWidget(data: data)
            case .systemLarge:
                smallWidget(data: data)
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
            .padding(.all, 10)
            .background(Color.pink)
            VStack(alignment:.leading){
            smallWidgetBlock(type: .total, count: Int(data.total), color: .coronapink)
            smallWidgetBlock(type: .recovered, count: Int(data.recovered), color: .coronagreen)
            smallWidgetBlock(type: .deaths, count: Int(data.deaths), color: .coronagrey)
            smallWidgetBlock(type: .active, count: Int(data.active), color: .coronayellow)
            }
        }
    }
}

struct smallWidgetBlock : View {
    var type : coronaType
    var count : Int
    var color : Color
    var body: some View {
        HStack {
            Image(type.image)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
            
            Text(type.title + " " + type.subtitle)
                .font(.system(size: 15))
            Text("\(count)")
                .foregroundColor(color)
                .bold()
        }
    }
}

struct mediumWidget : View {
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
            .padding(.all, 10)
            .background(Color.pink)
            GraphView(country: data)
            Spacer()
        }
    }
}

struct GraphView : View {
    var country : CountryModel
    var body: some View {
        GeometryReader(content: { geometry in
            VStack{
                Line(end: geometry.size.width * 0.75, value: country.total, color: .coronapink)
                Line(end: geometry.size.width * recoveredpercent(), value: country.active, color: .coronagreen)
                Line(end: geometry.size.width * deathPercent(), value: country.deaths, color: .coronagrey)
                Line(end: geometry.size.width * activepercent(), value: country.active, color: .coronayellow)
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


struct Line : View {
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
        WidgetView(data: CountryModel(date: Date(), total: 100, active: 30, deaths: 20, recovered: 50,name: "India",emoji: "🇮🇳"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
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
            return "Total"
        case .recovered:
            return "Total"
        }
    }
    
    var subtitle : String {
        switch self {
        case .total:
            return "Count"
        case .active:
            return "Cases"
        case .deaths:
            return "Deaths"
        case .recovered:
            return "Recoveries"
        }
    }
    
    
}
