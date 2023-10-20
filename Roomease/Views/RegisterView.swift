//
//  RegisterView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI

struct CreateAccountFormView: View {
    @Binding var firstName: String
    @Binding var lastName: String
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
                        
                        CustomTextField(placeHolder: "Email       ", bColor: textColor, tOpacity: 0.6, value: $email)
                        
                        CustomTextField(placeHolder: "Password", bColor: textColor, tOpacity: 0.6, value: $password)
                        
                    }.padding(.horizontal, 45)
                                        
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
    
    @State var errorCode = ""
    @State private var registrationSuccessful = false
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationView {
            
            
            ZStack (alignment: .center){
            
                CreateAccountFormView(firstName: $registrationViewModel.firstname, lastName: $registrationViewModel.lastname, email: $registrationViewModel.email, password: $registrationViewModel.password)
                
                Button(action: {
                    if validateInput() {
                        Task {
                            do {
                                try await registrationViewModel.register()
                                registrationSuccessful = true
                                //TODO: Save error message and print it.
                            } catch {
                                errorCode = "Registration Failed"
                            }
                        }
                    } else {
                        errorCode = "Please Enter Valid Credentials"
                    }
                }) {
                    Text("Create Account").fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 58)
                        .frame(minWidth: 0, maxWidth: 300)
                        .background(bttnColor)
                        .cornerRadius(20.0)
                }.padding(.top, 400)
                
                Text(errorCode)
                    .foregroundColor(.red)
                    .padding(.top, 310)
                
                
            }
            
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $registrationSuccessful) {
            JoinView()
        }
        
    }
                
    
    
    func validateInput() -> Bool {
        return !registrationViewModel.firstname.isEmpty &&
        !registrationViewModel.lastname.isEmpty &&
        !registrationViewModel.email.isEmpty &&
        !registrationViewModel.password.isEmpty
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
