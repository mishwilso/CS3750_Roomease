import SwiftUI

/*
    Used the following resources:
    https://developer.apple.com/documentation/swiftui/environmentvalues/calendar
    https://sarunw.com/posts/swiftui-tabview/
    https://codingwithrashid.com/how-to-align-vstack-items-to-top-in-ios-swiftui/
    https://www.hackingwithswift.com/forums/swiftui/creating-a-daily-view-calendar-with-overlapping-events/22436
    https://blog.logrocket.com/working-calendars-swift/#create-swift-ui-project
    https://www.swiftyplace.com/blog/tabview-in-swiftui-styling-navigation-and-more
*/

struct SliderView: View {
    @StateObject var weekStore = WeekStore()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    private var today = Date()
    var body: some View {
        ZStack {
            ForEach(weekStore.allWeeks) { week in
                VStack{
                    HStack {
                        ForEach(0..<7) { index in
                            VStack(spacing: 20) {
                                Text(weekStore.dateToString(date: week.date[index], format: "EEE"))
                                    .font(.system(size:14))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth:.infinity)
                                
                               // highlight today in dark blue
                                
                                if weekStore.isCurrDate(date: week.date[index]) && week.date[index] != weekStore.currentDate {
                                    Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                        .font(.system(size:14))
                                        .foregroundColor(.white)
                                        .bold()
                                        .frame(maxWidth:.infinity)
                                        .background (
                                            Circle()
                                                .fill(.blue)
                                                .opacity(0.5)
                                                .frame(width: 40, height: 40)
                                                
                                        )
                                }
                                // highlight the selected day in light blue
                                 else if week.date[index] == weekStore.currentDate {
                                    Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                        .font(.system(size:14))
                                        .frame(maxWidth:.infinity)
                                        .foregroundColor(.white)
                                        .background (
                                            Circle()
                                                .fill(.blue)
                                                .opacity(1.0)
                                                .frame(width: 40, height: 40)
                                        )
                                }
                                
                                
                                
                                // keep the background white
                                else {
                                    Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                        .font(.system(size:14))
                                        .frame(maxWidth:.infinity)
                                        .background (
                                            Rectangle()
                                                .fill(.white)
                                                .frame(width: 50, height: 50)
                                        )
                                }
                                
                                    
                            }
                            .onTapGesture {
                                // Updating Current Day
                                weekStore.currentDate = week.date[index]
                            }
                            
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(
                        Rectangle()
                            .fill(.white)
                    )
                    
                    
                    
                }
                .offset(x: myXOffset(week.id), y: 0)
                .zIndex(1.0 - abs(distance(week.id)) * 0.1)
                .padding(.horizontal, 20)
             
                
            }
            
        }
        .frame(alignment: .top)
        .padding(.top,50)
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 400
                }
                .onEnded { value in
                    withAnimation {
                        if value.predictedEndTranslation.width > 0 {
                            draggingItem = snappedItem + 1
                        } else {
                            draggingItem = snappedItem - 1
                        }
                        snappedItem = draggingItem
                        
                        weekStore.update(index: Int(snappedItem))
                    }
                }
            
        )
        
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(weekStore.allWeeks.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(weekStore.allWeeks.count) * distance(item)
        return sin(angle) * 200
    }
    
    func getDate() -> Date {
        return weekStore.currentDate
    }
    
}

struct WeekView: View {
    @State var date : Date = Date()
    var body: some View {
        VStack {
            SliderView()
                .padding(.bottom, 50)
            EventView(date: $date)
        }
        
    }
}
#Preview {
    WeekView()
}
