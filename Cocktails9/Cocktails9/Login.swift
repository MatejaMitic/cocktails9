//
//  login.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 26.11.24..
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showRegisterView: Bool = false
    @State private var currentImageName: String = "cocktailP1"
    
    
    // Sample credentials for demonstration
    let validUsername = "user"
    let validPassword = "123"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("LoGin")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .frame(width: 100, height: 25)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top)
                }
                Spacer()
                
                Image(currentImageName)
                    .resizable()
                    .scaledToFit()
                    .animation(.easeInOut, value: currentImageName)
                
                
                Button(action: {
                    showRegisterView = true
                }) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                .navigationDestination(isPresented: $showRegisterView) {
                    Register()
                    
                }
                
            }
            .padding(.top, 150.0)
            .padding(.horizontal, 20)
            .background(Color.green.opacity(0.2))
            
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .animation(.easeInOut(duration: 0.5), value: currentImageName)
        }
    }
    
    
    private func login() {
        var isLoggedIn = false
        if username == validUsername && password == validPassword {
            isLoggedIn = true
            // Only update alert message if login fails
            alertMessage = "" // Clear any previous alert message
        } else {
            isLoggedIn = false
            alertMessage = "Invalid credentials. Please try again."
        }
        
        if !isLoggedIn {
            showAlert = true
        }
        withAnimation{
            currentImageName = (isLoggedIn) ? "cocktailP2" : "cocktailP1"
        }
    }
    
    
}



#Preview {
    LoginView()
}
