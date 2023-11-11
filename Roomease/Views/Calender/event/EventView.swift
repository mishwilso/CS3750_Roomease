//
//  EventView.swift
//  Roomease
//
//  Created by Molly Pate on 11/11/23.
//

import SwiftUI

struct EventView: View {
    @Binding var date: Date
    var body: some View {
        // get all the events for today
        //let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        ScrollView {
            // TODO: display today's events
            Text("Event 1: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 2: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 3: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 4: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 5: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 6: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 7: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 8: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 9: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 10: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 11: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 12: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 13: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 14: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 15: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 16: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 17: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 18: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 19: 11/11/2023 from 10:00 to 12:00")
            Text("")
            Text("Event 20: 11/11/2023 from 10:00 to 12:00")
            

        }
        
    }
    func dummyFunc() -> [Int] {
        var nums : [Int] = []
        for i in 0...100 {
            nums.append(i)
        }
        return nums
    }
    
    func getTodaysEvents() -> [[Any]] {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        let day = dateComponents.day ?? 01
        let month = dateComponents.month ?? 01
        let year = dateComponents.year ?? 2023
        
        var todaysEvents : [[Any]] = []
        // TODO: get firebase to collect all events
        // here is some dummy data
        // order is day, endTime, month, startTime, title, year
        let events = [[11, "19:00", 11, "21:15", "Study", 2023], [11, "11:00", 11, "21:15", "Eat", 2023], [11, "19:00", 11, "21:15", "Sleep", 2023], [11, "19:00", 11, "22:15", "Play", 2023], [11, "19:00", 12, "21:15", "Watch TV", 2023]]
        print(type(of: events))
        for i in 0..<events.count {
            if events[i][0] as! Int == day && events[i][2] as! Int == month && events[i][5] as! Int == year {
                todaysEvents.append(events[i])
            }
        }
        return todaysEvents
    }
}


