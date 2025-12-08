
import SwiftUI

struct MainTabView: View {
    var body: some View {
        
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                WorkoutsView()
                    .tabItem {
                        Image(systemName: "figure")
                        Text("Workouts")
                    }
                
                ProgressView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Progress")
                    }
                
                SettingsView()
                
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .tint(.orange)
        }
        
        //        TabView {
        //            NavigationStack {
        //                HomeView()
        //            }
        //            .tabItem {
        //                Image(systemName: "house.fill")
        //                Text("Home")
        //            }
        //
        //            NavigationStack {
        //                WorkoutsView()
        //            }
        //            .tabItem {
        //                Image(systemName: "figure")
        //                Text("Workouts")
        //            }
        //
        //            NavigationStack {
        //                ProgressView()
        //            }
        //            .tabItem {
        //                Image(systemName: "chart.bar")
        //                Text("Progress")
        //            }
        //
        //            NavigationStack {
        //                SettingsView()
        //            }
        //            .tabItem {
        //                Image(systemName: "gear")
        //                Text("Settings")
        //            }
        //        }
        //        .tint(.orange)
    }
}

//struct MainTabView: View {
//    var body: some View {
//        NavigationStack{
//            TabView {
//                HomeView()
//                    .tabItem {
//                        Image(systemName: "house.fill")
//                        Text("Home")
//                    }
//                WorkoutsView()
//                    .tabItem {
//                        Image(systemName: "figure")
//                        Text("Workouts")
//                    }
//                ProgressView(    )
//                    .tabItem {
//                        Image(systemName: "chart.bar")
//                        Text("Progress")
//                    }
//                SettingsView()
//                    .tabItem {
//                        Image(systemName: "gear")
//                        Text("Settings")
//                    }
//            }
//            .tint(.orange)
//        }
//    }
//}

#Preview {
    MainTabView()
}



