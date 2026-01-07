import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("Create Workout")
                    .font(.largeTitle)
                    .bold()

                Text("Build your custom workout plan")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Workout name")
                    .font(.headline)

                TextField("e.g Morning Workout", text: $viewModel.workoutName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Text("Exercises:")
                    .font(.headline)

                


                NavigationLink {
                    AddExerciseView()
                        .environmentObject(viewModel)
                } label: {
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
                
                ForEach(viewModel.exercises) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.exercise.name)
                            .font(.headline)

                        Text("\(item.sets) sets • \(item.repsOrTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding(6)
        }
    }
}


#Preview {
    WorkoutsView()
}
