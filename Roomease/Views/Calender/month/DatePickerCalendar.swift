import SwiftUI

/*
    Used the following resources:
    https://developer.apple.com/documentation/swiftui/environmentvalues/calendar
*/

struct DatePickerCalendar: View {
    @State var selectedDate = Date()
    var body: some View {
        VStack {
            FormattedDate(selectedDate: selectedDate, omitTime: true)
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate,
                       in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
            Divider()
        }
    }
}

struct DatePickerCalendar_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerCalendar()
    }
}
