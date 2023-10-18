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
        NavStackView()
        
    }
}


let lightGray = Color(red: 0.8, green: 0.8, blue: 0.8)

let lighterGray = Color(red: 0.9, green: 0.9, blue: 0.9)

let bttnColor = "red: 0.8, green: 0.8, blue: 0.8"

let textColor = Color(red: 0, green: 0, blue: 0)

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
    @State private var isLinkActive = false
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                ZStack {
                    
                    Rectangle()
                        .frame(width: 308, height: 215).cornerRadius(15.0)
                        .foregroundColor(lightGray)
                        .padding(.top, 500)
                    
                    Ellipse()
                        .frame(width: 458, height: 500)
                        .padding(.trailing, -450)
                        .foregroundColor(lighterGray)
                        .padding(.top, -370)
                    
                    Ellipse()
                        .frame(width: 510, height: 400)
                        .padding(.leading, -100)
                        .foregroundColor(lighterGray)
                        .padding(.top, -500)
                    
                    
                    
                    Text("Welcome to\nRoommease!")
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 50).padding(.top, -300)
                    
                }
                VStack(spacing: 80) {
                  
                    
                    //Image(.tempLogo).resizable().aspectRatio(contentMode: .fit).padding(.top, 1).padding()
                    
                    
                    VStack(spacing: 30){
                        
                        
                        Spacer().frame(height: 470)
                        
                        NavigationLink(destination: CreateAccountView(),
                                       label: { Text("Create Account").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lighterGray))})
                        
                        NavigationLink(destination: LoginView(),
                                       label: {     Text("Login").font(.smallFont).frame(width: 250.0, height: 60).background(RoundedRectangle(cornerRadius: 7).fill(lighterGray))})
                        
                    }
                }.padding(.top, 0)
            }

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



struct LoginFormView: View {
    @Binding var username: String
    @Binding var password: String

    var body: some View {
        ZStack (alignment: .center) {
            ZStack {
                
                Rectangle()
                    .frame(width: 458, height: 420)
                    .foregroundColor(lightGray)
                    .padding(.top, 1100)
                
                Ellipse()
                    .frame(width: 458, height: 420)
                    .padding(.trailing, -500)
                    .foregroundColor(lighterGray)
                    .padding(.top, -550)
                
                Ellipse()
                    .frame(width: 510, height: 478)
                    .padding(.leading, -200)
                    .foregroundColor(lightGray)
                    .padding(.top, -590)
                
                Text("Welcome \nBack")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 50).padding(.top, -250)
                
            }
                                
                
                
                
                VStack (spacing: 40){
                    //Add decor stuff in a ZStack Here
                    
                    VStack (spacing: 40){
                        
                        VStack (spacing: 30) {
                            CustomTextField(placeHolder: "Username", bColor: textColor, tOpacity: 0.6, value: $username)
                            
                            CustomTextField(placeHolder: "Password", bColor: textColor, tOpacity: 0.6, value: $password)
                            
                        }.padding(.horizontal, 50)
                        
                        //Insert stuff for "Don't have an account", here
                        
                    }
                    
                }
            
            HStack{
                Text("Don't Have An Account? ").fontWeight(.bold).foregroundColor(.white)
                
                NavigationLink(destination: CreateAccountView(), label: {Text("Sign Up").foregroundColor(.gray)})
            }.padding(.top, 750)
            
            }
            .edgesIgnoringSafeArea(.bottom)
            

        }

    }
  


struct LoginView: View {

    @State var username = ""
    @State var password = ""
    @State var leavePage = false
    @State var errorCode = ""
    //@State var isLinkActive = ""

    var body: some View {
        NavigationView {
            
            ZStack (alignment: .center){
                LoginFormView(username: $username, password: $password)
                
                //Sign in button
                
                if(username.isEmpty || password.isEmpty){
                    VStack{
                        Text(errorCode).foregroundColor(.red)
                        Button(action: { errorCode = "Please Enter valid Password and Username"}, label: {
                            CustomButton(bttnTitle: "Sign In", bColor: bttnColor)
                        })
                    }.padding(.top, 300)
                } else {
                    
                    NavigationLink(destination: ContentView(), label: {CustomButton(bttnTitle: "Sign In", bColor: bttnColor)}).padding(.top, 300)
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct CreateAccountFormView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var username: String
    @Binding var password: String
    
    var body: some View {
        ZStack (alignment: .center) {
            ZStack {
                
                Rectangle()
                    .frame(width: 458, height: 420)
                    .foregroundColor(lightGray)
                    .padding(.top, 1100)
                
                Ellipse()
                    .frame(width: 458, height: 420)
                    .padding(.trailing, -500)
                    .foregroundColor(lighterGray)
                    .padding(.top, -620)
                
                Ellipse()
                    .frame(width: 510, height: 478)
                    .padding(.leading, -100)
                    .foregroundColor(lightGray)
                    .padding(.top, -650)
                
                
                
                Text("Create \nAccount")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 70).padding(.top, -300)
                
            }
            
            
            VStack (spacing: 40){
                //Add decor stuff in a ZStack Here
                
                VStack (spacing: 40){
                    
                    VStack (spacing: 30) {
                        CustomTextField(placeHolder: "First Name", bColor: textColor, tOpacity: 0.6, value: $firstName)
                        
                        CustomTextField(placeHolder: "Last Name", bColor: textColor, tOpacity: 0.6, value: $lastName)
                        
                        CustomTextField(placeHolder: "Username", bColor: textColor, tOpacity: 0.6, value: $username)
                        
                        CustomTextField(placeHolder: "Password", bColor: textColor, tOpacity: 0.6, value: $password)
                        
                    }.padding(.horizontal, 50)
                    
                    //Insert stuff for "Don't have an account", here
                    
                }
                
            }
            
            HStack{
                Text("Have An Account? ").fontWeight(.bold).foregroundColor(.white)
                
                NavigationLink(destination: LoginView(), label: {Text("Log-In").foregroundColor(.gray)})
            }.padding(.top, 750)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
    
}

struct CreateAccountView: View {

    @State var firstName = ""
    @State var lastName = ""
    @State var username = ""
    @State var password = ""
    @State var errorCode = ""

    var body: some View {
        NavigationView {
            
            ZStack (alignment: .center){
                CreateAccountFormView(firstName: $firstName, lastName: $lastName, username: $username, password: $password)
                
                //Sign in button
                if(username.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty){
                    VStack{
                        Text(errorCode).foregroundColor(.red)
                        Button(action: { errorCode = "Please Enter valid Credentials"}, label: {
                            CustomButton(bttnTitle: "Create Account", bColor: bttnColor)
                        })
                    }.padding(.top, 400)
                } else {
                    
                    NavigationLink(destination: JoinView(name: User(fname: firstName, lname: lastName)), label: {CustomButton(bttnTitle: "Create Account", bColor: bttnColor)}).padding(.top, 400)
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

//Set This up Properly
struct User{
    var fname: String
    var lname: String
}

//Recreate Join and Create House View
struct JoinView: View {
    let name: User
    
    var body: some View{
        Text("Hi \(name.fname) \(name.lname)")
    }
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
                        Text(placeHolder).foregroundColor(lightGray.opacity(tOpacity)).padding(.trailing, 220).font(.regularFont)
                    }

                    SecureField("", text: $value).padding(.leading, 12).font(.regularFont).frame(height: 45).autocorrectionDisabled(true).autocapitalization(.none)
                }
            }

            else {
                ZStack {
                    if value.isEmpty {
                        Text(placeHolder).foregroundColor(lightGray.opacity(tOpacity)).padding(.trailing, 220).font(.regularFont)
                    }

                    TextField("", text: $value).padding(.leading, 12).font(.regularFont).frame(height: 45).autocorrectionDisabled(true).autocapitalization(.none)
                }
            }
        }
        .overlay(
            Divider().overlay(bColor.opacity(tOpacity)).padding(.horizontal, 20), alignment: .bottom
        )
    }
}

//Custom Button
struct CustomButton: View {

    var bttnTitle: String
    var bColor: String

    var body: some View {
        Text(bttnTitle).fontWeight(.bold).foregroundColor(.white).frame(height: 58).frame(minWidth: 0, maxWidth: 300).background(lightGray).cornerRadius(20.0)
    }
}

