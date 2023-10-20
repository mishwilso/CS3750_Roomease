//
//  NavView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI


//For Testing
struct ScreenOneView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Screen One!")
            
        }
    }
}
struct ScreenTwoView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Screen Two!")
            
        }
    }
}

struct NavView: View {
    var body: some View {
        NavigationView {
            TabView {
                ScreenOneView()
                    .tabItem {
                        //Image(systemName: "phone.fill")
                        Text("One")
                    }
                CalendarView()
                    .tabItem {
                        //Image(systemName: "tv.fill")
                        Text("Calender")
                    }
            }.onAppear() {
                UITabBar.appearance().barTintColor = UIColor(lightGray)
                UITabBar.appearance().backgroundColor = UIColor(lightGray)
            }
        }.navigationBarHidden(true)
    }
}
