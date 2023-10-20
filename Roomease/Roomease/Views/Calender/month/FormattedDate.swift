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

struct FormattedDate: View {
    var selectedDate: Date
    var omitTime: Bool = false
    var body: some View {
        Text(selectedDate.formatted(date: .abbreviated, time:
              omitTime ? .omitted : .standard))
            .font(.system(size: 28))
            .bold()
            .foregroundColor(Color.accentColor)
            .padding()
            .animation(.spring(), value: selectedDate)
            .frame(width: 500)
    }
}

struct FormattedDate_Previews: PreviewProvider {
    static var previews: some View {
        FormattedDate(selectedDate: Date())
    }
}
