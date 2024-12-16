import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showRegisterView: Bool = false
    @State private var currentImageName: String = "bela casa"
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToMain: Bool = false;
    
    
    
    // Private function to retrieve user from UserDefaults
    private func getUser(for email: String) -> User? {
        if let savedData = UserDefaults.standard.data(forKey: email) {
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(User.self, from: savedData) {
                return decodedUser
            }
        }
        return nil
    }
    
    // Private function to add user to UserDefaults
    private func addUser(_ user: User) {
        // Encode user and save it to UserDefaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: user.email)
        }
    }
    
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
        
        if let _ = getUser(for: email) {
            alertMessage = "An account with this email already exists."
            showAlert = true
            return
        }
        
        // Create new user with empty favorite cocktails list
        let newUser = User(email: email, username: username, password: password, favoriteCocktails: [])
        
        UserManager.saveUser(newUser)
        
        AppDataManager.shared.user?.email = newUser.email
        
        email = ""
        username = ""
        password = ""
        
        withAnimation {
            currentImageName = (currentImageName == "bela casa") ? "koka" : "bela casa"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            navigateToMain = true //
        }
        
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Regi")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
                + Text("Star")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundColor(.red.opacity(0.8))
                
                
                TextField("Email", text: $email)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                    .accessibilityLabel("Email Address")
                
                TextField("Username", text: $username)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                    .accessibilityLabel("Username")
                
                SecureField("Password", text: $password)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                    .accessibilityLabel("Password")
                
                Button(action: {
                    registerUser()
                }) {
                    Text("Register")
                        .frame(width: 200, height: 45)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 20)
                        .font(.headline)
                }
                
                Spacer()
                
                Image(currentImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)
                    .animation(.easeInOut, value: currentImageName)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account? Login")
                        .foregroundColor(.blue)
                        .font(.footnote)
                        .padding(.top)
                }
                .navigationDestination(isPresented: $showRegisterView) {
                    
                }
                .navigationDestination(isPresented: $navigateToMain) {
                    MainTabView()
                        .navigationBarBackButtonHidden(true)
                }
                
                .padding(.top)
            }
            .padding(.horizontal, 20)
            .background(Color.red.opacity(0.2))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registration Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .animation(.easeInOut(duration: 0.5), value: currentImageName)
            
        }
    }
}

#Preview {
    RegisterView()
}
