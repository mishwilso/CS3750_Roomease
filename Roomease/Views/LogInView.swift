//
//  LogInView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI

struct LoginFormView: View {
    @Binding var email: String
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
                    .padding(.leading, 70).padding(.top, -250)
                
            }
            
            
            
            
            VStack (spacing: 40){
                //Add decor stuff in a ZStack Here
                
                VStack (spacing: 40){
                    
                    VStack (spacing: 30) {
                        CustomTextField(placeHolder: "Email      ", bColor: textColor, tOpacity: 0.6, value: $email)
                        
                        CustomTextField(placeHolder: "Password", bColor: textColor, tOpacity: 0.6, value: $password)
                        
                    }.padding(.horizontal, 45)
                    
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


//TODO: Add a Reset Password Feature
struct LoginView: View {

    @State var errorCode = ""
    @State private var loginSuccessful = false
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack (alignment: .center){
                
                LoginFormView(email: $loginViewModel.email , password: $loginViewModel.password)
                
                //Sign in button
                Button(action: {
                    if validateInput(){
                        Task {
                            do {
                                try await loginViewModel.signIn()
                                loginSuccessful = true
                            } catch {
                                errorCode = "Login Failed"
                            }
                        }
                    } else {
                        errorCode = "Please Enter Valid Credentials"
                    }
                }) {
                    Text("Log In").fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 58)
                        .frame(minWidth: 0, maxWidth: 300)
                        .background(bttnColor)
                        .cornerRadius(20.0)
                    
                }.padding(.top, 300)
                
                Text(errorCode)
                    .foregroundColor(.red)
                    .padding(.top, 200)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $loginSuccessful) {
            NavView()
        }
    }
                
    func validateInput() -> Bool {
        return  !loginViewModel.email.isEmpty &&
        !loginViewModel.password.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
