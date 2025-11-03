import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    Text("Workout Tracker")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Let's get moving")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.orange)
                        .frame(height: 130)
                        .overlay(
                            HStack{
                                VStack(alignment: .leading, spacing: 10){
                                    HStack(spacing: 16){
                                        Image(systemName: "flame.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                        Text("0 Workouts")
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    Text("0 Templates Created")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                }
                                    .padding(20)
                                Spacer()
                            }
                        )
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                        HomeActionCard(title: "Start Workout", color: .orange, icon: "figure")
                        HomeActionCard(title: "Progress", color: .blue, icon: "chart.bar")
                        HomeActionCard(title: "Create Workout", color: .purple, icon: "plus")
                        HomeActionCard(title: "Settings", color: .gray, icon: "gear")
                    }
                }
                .padding(6)
            }
        }
    }
}

#Preview {
    MainTabView()
}
