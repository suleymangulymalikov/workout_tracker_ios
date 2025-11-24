import SwiftUI

struct WorkoutsView: View {
    @State private var workoutName = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20){
                Text("Create Workout")
                    .font(.largeTitle)
                    .bold()
                
                Text("Build your custom workout plan")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Workout name")
                    .font(.headline)
                
                TextField("e.g Morning Workout", text: $workoutName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                HStack {
                    Text("Exercises:")
                        .font(.headline)
                    
                    Spacer()
                    
                    NavigationLink(destination: AddExerciseView()){
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Exercise")
                        }
                        .foregroundColor(.orange)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                
            }
            .padding(6)
        }
    }
}

#Preview {
    WorkoutsView()
}

