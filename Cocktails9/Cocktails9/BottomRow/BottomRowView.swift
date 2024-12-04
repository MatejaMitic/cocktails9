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
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                FavoritesView()
                    .tag(1)
                
                ProfileView()
                    .tag(3)
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
        .frame(height: 70)
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
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
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
