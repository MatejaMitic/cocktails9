import SwiftUI

struct BottomRowView: View {
    @State var selectedTab = 0
    
    enum TabbedItems: Int, CaseIterable{
        case cocktails = 0
        case favorites
        case profile
        
        var title: String{
            switch self {
            case .cocktails:
                return "Cocktails"
            case .favorites:
                return "Favorites"
            case .profile:
                return "Profile"
            }
        }
        
        var iconName: String{
            switch self {
            case .cocktails:
                return "wineglass.fill"
            case .favorites:
                return "star.fill"
            case .profile:
                return "person.fill"
            }
        }
    }
    
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    Group {
                        //HomeView()
                        DrinksGrid()
                            .background(Color.green.opacity(0.2))
                            .tag(0)
                        
                        FavoritesView()
                            .background(Color.green.opacity(0.2))
                            .tag(1)
                        
                        ProfileView()
                            .tag(2)
                    }
//                    .toolbarBackground(.clear, for: .tabBar)
                        .toolbarBackground(.hidden, for: .tabBar)
//                        .toolbarColorScheme(.dark, for: .tabBar)
                }

            }
        }
        ZStack{
            HStack{
                ForEach((TabbedItems.allCases), id: \.self){ item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 60)
        .background(Color.clear)
        .cornerRadius(35)
        .padding(.horizontal, 26)
    }
}

extension BottomRowView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .foregroundColor(isActive ? .black : .gray)
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .green.opacity(0.2) : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    NavigationStack {
        BottomRowView()
    }
}
