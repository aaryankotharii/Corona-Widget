//
//  ContentView.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 21/07/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var corona = SessionStore()
    var body: some View {
        Text("\(corona.current?.Global.TotalDeaths ?? 0)").padding()
            .onAppear {
                corona.fetch{ idk in
                    
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
