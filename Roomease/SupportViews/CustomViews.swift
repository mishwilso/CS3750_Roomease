//
//  CustomViews.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI



//Set This up Properly
struct User{
    var fname: String
    var lname: String
}



//Custom Text Field Things
struct CustomTextField: View {
    var placeHolder: String
    var bColor: Color
    var tOpacity: Double
    @Binding var value: String

    var body: some View {
        HStack {
        //Maybe add image thing

            if placeHolder == "Password" {
                ZStack {
                    if value.isEmpty {
                        Text(placeHolder).foregroundColor(bColor.opacity(tOpacity)).padding(.trailing, 220).font(.regularFont)
                    }

                    SecureField("", text: $value).padding(.leading, 30).font(.regularFont).frame(height: 45).autocorrectionDisabled(true).autocapitalization(.none)
                }
            }

            else {
                ZStack {
                    if value.isEmpty {
                        Text(placeHolder).foregroundColor(bColor.opacity(tOpacity)).padding(.trailing, 220).font(.regularFont)
                    }

                    TextField("", text: $value).padding(.leading, 30).font(.regularFont).frame(height: 45).autocorrectionDisabled(true).autocapitalization(.none)
                }
            }
        }
        .overlay(
            Divider().overlay(bColor.opacity(tOpacity)).padding(.horizontal, 30), alignment: .bottom
        )
    }
}

//Custom Button
struct CustomButton: View {

    var bttnTitle: String
    var bColor: Color

    var body: some View {
        Text(bttnTitle).font(.regularFont).fontWeight(.bold).foregroundColor(.white).frame(height: 58).frame(minWidth: 0, maxWidth: 300).background(bColor).cornerRadius(20.0)
    }
}


//Custom Error Code
enum DBError: Error {
    case registrationFailed(errorMessage: String)
    case loginFailed(errorMessage: String)
}
