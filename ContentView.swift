//
//  ContentView.swift
//  Test
//
//  Created by user247737 on 10/16/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}


struct ContentView_Provider: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let lightGray = Color(red: 0.8, green: 0.8, blue: 0.8)

let lighterGray = Color(red: 0.9, green: 0.9, blue: 0.9)

let bttnColor = "red: 0.8, green: 0.8, blue: 0.8"

let textColor = "red: 0, green: 0, blue: 0"

let white = Color(red: 1, green: 1, blue: 1)

extension Font {
    static let headerFont = Font.custom("Sans-Regular", size: Font.TextStyle.largeTitle.size, relativeTo: .caption)
    static let subHeaderFont = Font.custom("Sans-Regular", size: Font.TextStyle.title.size, relativeTo: .caption)
    static let regularFont = Font.custom("Sans-Regular", size: Font.TextStyle.body.size, relativeTo: .caption)
    static let smallFont = Font.custom("Sans-Regular", size: Font.TextStyle.subheadline.size, relativeTo: .caption)
    static let largeFont = Font.custom("Sans-Regular", size: Font.TextStyle.caption2.size, relativeTo: .caption)
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        //Header
        case .largeTitle: return 45

        //Subheader
        case .title: return 29

        case .title2: return 34
        case .title3: return 24

        //Regular
        case .headline, .body: return 19

        //smallfont
        case .subheadline, .callout: return 14
        case .footnote: return 14
        case .caption: return 19

        //Largefont
        case .caption2: return 25
        @unknown default:
            return 20
        }
    }
}

struct FontView: View {
    var body: some View {
        VStack {
            Text("Hello, world!").font(.headerFont)
            Text("Hello, world!").font(.subHeaderFont)
            Text("Hello, world!").font(.regularFont)
            Text("Hello, world!").font(.smallFont)
            Text("Hello, world!").font(.largeFont)
        }
    }
}



struct NavStackView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 50){
                NavigationLink(destination: CreateAccountView(firstName: $firstName, lastName: $lastName, username: $username, password: $password),
                    label: { Text("Create Account").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))})
                Spacer().frame(height: 1.0)
                NavigationLink(destination: LoginView(username: $username, password: $password),
                               label: { Text("Login").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))})
            }

        }
    }
}

struct LoginView: View {

    @Binding var username: String
    @Binding var password: String
    @State var household = ""


    var body: some View {
        VStack(spacing: 120) {
            Text("Log-In").font(.headerFont).multilineTextAlignment(.leading)//.navigationBarTitle("Create Account Screen") displayMode: .inline)

            VStack(alignment: .leading, spacing: 30.0) {
                
                Text("Username").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $username).font(.regularFont);

                Text("Password").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $password).font(.regularFont);

                NavigationLink(destination: JoinHouseView(), label: { Text("Log-In").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))})
            }
            .padding(.horizontal, 60.0)

            //For actual program:
//.navigationBarBackButtonHidden(true)
        }
    }
}


struct CreateAccountView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var username: String
    @Binding var password: String
    @State var household = ""


    var body: some View {
        VStack(spacing: 120) {
            Text("Create Account").font(.headerFont).multilineTextAlignment(.leading)//.navigationBarTitle("Create Account Screen") displayMode: .inline)

            VStack(alignment: .leading, spacing: 30.0) {
                
                Text("First Name").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $firstName).font(.regularFont);
                
                Text("Last Name").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $lastName).font(.regularFont);
                
                Text("Username").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $username).font(.regularFont);

                Text("Password").font(.smallFont)
                    .multilineTextAlignment(.leading); TextField("", text: $password).font(.regularFont);

                NavigationLink(destination: JoinHouseView(), label: { Text("Create Account").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))})
            }
            .padding(.horizontal, 60.0)

            //For actual program:
//.navigationBarBackButtonHidden(true)
        }
    }
}

struct JoinHouseView: View{
    @State var householdcode = ""
    @State var householdname = ""

    var body: some View {
        
        VStack (spacing: 20) {
            
            ZStack {
                Text("").font(.smallFont).frame(width: 300.0, height: 200).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))
                VStack{
                    Text("Join Household").font(.subHeaderFont).frame(alignment: .leading)
                    
                    Spacer().frame(height: 25.0)
                    
                    TextField("Household Code", text: self.$householdcode).background(RoundedRectangle(cornerRadius: 7).fill(lighterGray)).frame(width: 200.0).textFieldStyle(PlainTextFieldStyle()).padding([.horizontal], 4).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray)).padding([.horizontal], 24);
                    
                    Spacer().frame(height: 25.0)
                    
                    NavigationLink(destination: ContentView(), label: { Text("Join").font(.smallFont).frame(width: 100.0, height: 40).background(RoundedRectangle(cornerRadius: 7).fill(white))})
                }
            }
            ZStack {
                Text("").font(.smallFont).frame(width: 300.0, height: 200).background(RoundedRectangle(cornerRadius: 7).fill(lightGray))
                VStack{
                    Text("Create Household").font(.subHeaderFont).frame(alignment: .leading)
                    
                    Spacer().frame(height: 25.0)
                    TextField("Household Name", text: self.$householdname).background(RoundedRectangle(cornerRadius: 7).fill(lighterGray)).frame(width: 200.0).textFieldStyle(PlainTextFieldStyle()).padding([.horizontal], 4).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray)).padding([.horizontal], 24);
                    
                    Spacer().frame(height: 25.0)
                    
                    NavigationLink(destination: ContentView(), label: { Text("Create House").font(.smallFont).frame(width: 100.0, height: 40).background(RoundedRectangle(cornerRadius: 7).fill(white))})
                }
            }
        }

        }
    }




//Stuff I wanted to test but my preview broke.

//struct LoginView: View {
//
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isLinkActive = false
//
//    var body: some View {
//        NavigationView {
//            ZStack (alignment: .topLeading) {
//                VStack {
//                    VStack (spacing: 40){
//                        //Add decor stuff in a ZStack Here
//
//                        VStack (spacing: 30){
//                            VStack (spacing: 30) {
//                                CustomTextField(placeHolder: "Username", bColor: "textColor", tOpacity: 0.6, value: $username)
//
//                                CustomTextField(placeHolder: "Password", bColor: textColor, tOpacity: 0.6, value: $password)
//                            }
//
//                            //Sign in button
//                            NavigationLink(destination: ContentView(), isActive: $isLinkActive){
//                                Button(action: {self.isLinkActive=true}, label: {
//                                CustomButton(bttnTitle: "Sign In", bColor: bttnColor)
//                                })
//                            }
//
//                        }.padding(.horizontal, 20)
//                    }
//                }
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        }
//        //.navigationBarHidden(true)
//    }
//}
//
//
//
//
////Custom Text Field Things
//struct CustomTextField: View {
//
//    var placeHolder: String
//    var bColor: String
//    var tOpacity: Double
//    @Binding var value: String
//
//    var body: some View {
//        HStack {
//        //Maybe add image thing
//
//            if placeHolder == "Password" {
//                ZStack {
//                    if value.isEmpty {
//                        Text(placeHolder).foregroundColor(Color(bColor).opacity(tOpacity)).padding(.leading, 12).font(.regularFont)
//                    }
//
//                    SecureField("", text: $value).padding(.leading, 12).font(.regularFont).frame(height: 45)
//                }
//            }
//
//            else {
//                ZStack {
//                    if value.isEmpty {
//                        Text(placeHolder).foregroundColor(Color(bColor).opacity(tOpacity)).padding(.leading, 12).font(.regularFont)
//                    }
//
//                    TextField("", text: $value).padding(.leading, 12).font(.regularFont).frame(height: 45).foregroundColor(Color(bColor))
//                }
//            }
//        }
//        .overlay(
//            Divider().overlay(Color(bColor).opacity(tOpacity)).padding(.horizontal, 20), alignment: .bottom
//        )
//    }
//}
//
////Custom Button
//struct CustomButton: View {
//
//    var bttnTitle: String
//    var bColor: String
//
//    var body: some View {
//        Text(bttnTitle).fontWeight(.bold).foregroundColor(.white).frame(height: 58).frame(minWidth: 0, maxWidth: .infinity).background(Color(bColor))
//    }
//}

