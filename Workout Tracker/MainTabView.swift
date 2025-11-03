
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
        }
        .tint(.orange)
    }
}

#Preview {
    MainTabView()
}



