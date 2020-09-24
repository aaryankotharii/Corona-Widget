//
//  ContentView.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 21/07/20.
//

import SwiftUI

// MARK:- THIS IS THE IOS APP FOR WHICH THE WIDGET HAS BEEN MADE. THE CONTENTS OF THIS APP DO NOT AFFECT THE WIDGET.

struct ContentView: View {
    // MARK - PROPERTIES
    @ObservedObject var corona = SessionStore()
    
    // MARK - BODY
    var body: some View {
        VStack{
            Spacer()
            Text("Hey There! 👋")
                .font(.system(size: 50, weight: .regular, design: .rounded))
            Spacer()
            VStack{
                Text("Total global cases:")
                    .font(.system(size: 20))
            Text("\(Int(corona.current?.Global.TotalConfirmed ?? 0))")
                .font(.system(size: 50))
                .padding()
            } //: VSTACK
            Spacer()
            buttonBar()
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(#colorLiteral(red: 0.631372549, green: 0.6, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        .onAppear(perform: fetch)
        .edgesIgnoringSafeArea(.all)
    } //: BODY
    
    /// FETCH CORONA DATA
    func fetch(){
        corona.fetch{ data in }
    }
}

// MARK - BOTTOM BAR WITH SOCIALS
struct buttonBar : View{
    var body : some View  {
        HStack(spacing:30){
            Link(destination: URL(string: "https://github.com/aaryankotharii")!) {
                Image("github")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            } //: LINK
            Link(destination: URL(string: "https://www.linkedin.com/in/aaryankotharii")!) {
                Image("LinkedIn")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            } //: LINK
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image("mail")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            } //: LINK
        } //: HSTACK
        .frame(height: 70, alignment: .center)
        .padding(.bottom, 40)
    } //: BODY
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
