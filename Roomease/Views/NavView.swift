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

struct ContentNavView: View {
    @State private var showMenu = false

    var body: some View {
            
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
                            showMenu = false
                        }
                    }
                }
            
            
            
            NavigationView {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        NavView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        if showMenu {
                            MenuView().frame(width: geometry.size.width/2)
                                .transition(.move(edge: .leading))
                        }
                        
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }
                        .padding(.bottom, 800).padding(.leading, 20)
                    }
                    .gesture(drag)
                }
                
                
            }.navigationBarHidden(true)
    
    }
}


struct NavView: View {
        
    var body: some View {
            NavigationView {
                @State var selection = 3
                TabView(selection: $selection) {
                    ChoreView()
                        .tabItem {
                            Label("Chores", systemImage: "list.dash")
                        } .tag(1)
                    CalendarView()
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }.tag(2)
                    ScreenOneView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }.tag(3)
                    GroceryView()
                        .tabItem {
                            Label("Grocery", systemImage: "cart")
                        }.tag(4)
                    ChatView()
                        .tabItem {
                            Label("Messages", systemImage: "paperplane")
                        }.tag(5)
                }.onAppear() {
                    UITabBar.appearance().barTintColor = UIColor(lightGray)
                    UITabBar.appearance().backgroundColor = UIColor(lightGray)
                }
            }.navigationBarHidden(true)
            
    }
}

struct ContentNavView_Previews: PreviewProvider {
    static var previews: some View {
        ContentNavView()
    }
}
