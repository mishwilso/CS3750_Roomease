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
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Working Progress Page!\nMore Coming Soon")
            
        }
    }
}

struct NavView: View {
    var body: some View {
        NavigationView {
            TabView {
                ScreenOneView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                        
                    }
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                ScreenOneView()
                    .tabItem {
                        Label("Chores", systemImage: "list.dash")
                    }
                ScreenOneView()
                    .tabItem {
                        Label("Grocery", systemImage: "cart")
                    }
                ScreenOneView()
                    .tabItem {
                        Label("Messages", systemImage: "paperplane")
                    }
            }.onAppear() {
                UITabBar.appearance().barTintColor = UIColor(lightGray)
                UITabBar.appearance().backgroundColor = UIColor(lightGray)
            }
        }.navigationBarHidden(true)
    }
}
