//
//  RegisterView.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 28.11.24..
//


import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showRegisterView: Bool = false
    @State private var currentImageName: String = "bela casa"
    
    // Store credentials in UserDefaults
    private func registerUser() {
        // Input Validation
        guard !email.isEmpty, !username.isEmpty, !password.isEmpty else {
            alertMessage = "All fields must be filled."
            showAlert = true
            return
        }
        
        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        // Save data to UserDefaults
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(username, forKey: "userUsername")
        UserDefaults.standard.set(password, forKey: "userPassword")
        
        // Optionally reset the fields or navigate to login
        email = ""
        username = ""
        password = ""
        
        withAnimation {
            currentImageName = (currentImageName == "bela casa") ? "koka" : "bela casa"
        }
        
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        // A basic regex for validating email
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("RegiStar")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    registerUser()
                }) {
                    Text("Register")
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
                    Text("Already have an account? Login")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                .navigationDestination(isPresented: $showRegisterView) {
                    // Login() view goes here
                }
                .padding(.top)
            }
            .padding(.top, 150.0)
            .padding(.horizontal, 20)
            .background(Color.red.opacity(0.2))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registration Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .animation(.easeInOut(duration: 0.5), value: currentImageName)
        }
    }
}

#Preview {
    RegisterView()
}
