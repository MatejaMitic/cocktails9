import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showRegisterView: Bool = false
    @State private var currentImageName: String = "cocktailP1" // Starting image for the animation
    @State private var navigateToMain: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Lo")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
                + Text("Gin")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundColor(.green)
                
                TextField("Email", text: $email)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                
                // Login Button
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .frame(width: 100, height: 45)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top)
                        .font(.headline)
                }
                
                Spacer()
                
                // Animated Cocktail Image
                Image(currentImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)
                    .animation(.easeInOut, value: currentImageName) // Only image animates
                
                // Register Button
                Button(action: {
                    showRegisterView = true
                }) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                .navigationDestination(isPresented: $showRegisterView) {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $navigateToMain) {
                    MainTabView()
                        .navigationBarBackButtonHidden(true)
                }
            
                
            }
            .padding(.top, 150)
            .padding(.horizontal, 20)
            .background(.green.opacity(0.2))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func login() {
        if let user = UserManager.loadUser(email: email) {
            if email == user.email && password == user.password {
                // Update user info in AppDataManager
                AppDataManager.currentEmail = email
                AppDataManager.shared.isLoggedIn = true
                alertMessage = ""
                showAlert = false
                
                // Animate the cocktail image change after successful login (No animation for text fields and title)
                withAnimation {
                    currentImageName = "cocktailP2" // Image transition to P2
                }
                
                // Simulate a delay for the animation and then navigate to the main screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    navigateToMain = true // Trigger navigation to the main screen after animation
                }
                
                return
            }
            
            alertMessage = "Invalid credentials. Please try again."
            showAlert = true
        } else {
            alertMessage = "No users found. Please register first."
            showAlert = true
        }
        
        // Ensure the animation is reset if login fails
        withAnimation {
            currentImageName = "cocktailP1" // Reset image on failure
        }
    }
}

#Preview {
    LoginView()
}
