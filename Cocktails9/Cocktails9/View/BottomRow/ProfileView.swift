import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var user: User = AppDataManager.shared.user ?? User(email: "", username: "Guest", password: "", favoriteCocktails: [])
    @State private var selectedItem: PhotosPickerItem? // To store the selected photo
    @State private var selectedImageData: Data? // To store the actual image data
    
    // State to control showing the photo picker
    @State private var isPhotoPickerPresented = false
    
    // Editable fields for username and password
    @State private var editedUsername = ""
    @State private var editedPassword = ""
    @State private var isEditingUsername = false
    @State private var isEditingPassword = false
    
    var body: some View {
        ZStack {
            // Background with green color and opacity
            Color.green.opacity(0.2)
                .edgesIgnoringSafeArea(.all) // Ensure the background covers the whole screen
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Profile Header with photo picker
                HStack {
                    // Profile Image Circle
                    PhotosPicker(
                        selection: $selectedItem, // Bind the selected item
                        matching: .images, // Limit picker to images
                        photoLibrary: .shared()) {
                            if let imageData = selectedImageData,
                               let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        Text(user.username.prefix(1)) // Display first letter of username if no image
                                            .font(.largeTitle)
                                            .bold()
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .onChange(of: selectedItem) { newItem, _ in
                            // Handle image selection
                            Task {
                                // Retrieve selected asset
                                if let selectedItem, let data = try? await selectedItem.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    user.profilePhotoData = data
                                    UserManager.saveUser(user)
                                }
                            }
                        }
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.username)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                
                Divider()
                
                // Editable Username Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Username")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    if isEditingUsername {
                        TextField("Enter new username", text: $editedUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                            .padding(.bottom)
                        
                        Button(action: {
                            // Save new username
                            user.username = editedUsername
                            UserManager.saveUser(user)
                            isEditingUsername = false
                        }) {
                            Text("Save")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.top)
                    } else {
                        Text(user.username)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.bottom)
                        
                        Button(action: {
                            editedUsername = user.username
                            isEditingUsername = true
                        }) {
                            Text("Edit")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                        }
                    }
                }
                .padding(.horizontal)

                Divider()

                // Editable Password Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Password")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    if isEditingPassword {
                        SecureField("Enter new password", text: $editedPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                            .padding(.bottom)
                        
                        Button(action: {
                            // Save new password
                            user.password = editedPassword
                            UserManager.saveUser(user)
                            isEditingPassword = false
                        }) {
                            Text("Save")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.top)
                    } else {
                        Text("••••••••") // Hide password
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.bottom)
                        
                        Button(action: {
                            editedPassword = user.password
                            isEditingPassword = true
                        }) {
                            Text("Edit")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

            }
            .padding()
            .cornerRadius(20)
            .onAppear {
                // Initialize the fields with the current user data
                editedUsername = user.username
                editedPassword = user.password
                if let profilePhotoData = user.profilePhotoData {
                    selectedImageData = profilePhotoData
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppDataManager.shared) // Provide shared data to view
    }
}
