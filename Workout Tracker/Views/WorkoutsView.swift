import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("Workouts")
                    .font(.largeTitle)
                    .bold()

                // 🏗 Create Workout
                VStack(alignment: .leading, spacing: 12) {
                    Text("Create Workout")
                        .font(.title2)
                        .bold()

                    TextField("Workout name", text: $viewModel.workoutName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    // Exercises being added
                    ForEach(viewModel.exercises) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.exercise.name)
                                    .font(.headline)
                                Text("\(item.sets) sets × \(item.reps) reps")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }

                    NavigationLink {
                        AddExerciseView()
                            .environmentObject(viewModel)
                    } label: {
                        Label("Add Exercise", systemImage: "plus")
                            .foregroundColor(.orange)
                    }

                    Button {
                        viewModel.saveWorkout()
                    } label: {
                        Text("Save Workout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                viewModel.workoutName.isEmpty || viewModel.exercises.isEmpty
                                ? Color.gray.opacity(0.4)
                                : Color.orange
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(viewModel.workoutName.isEmpty || viewModel.exercises.isEmpty)
                }

                Divider()

                // 📚 Saved Workouts
                Text("My Workouts")
                    .font(.title2)
                    .bold()

                if viewModel.workouts.isEmpty {
                    Text("No workouts yet")
                        .foregroundColor(.gray)
                }

                ForEach(viewModel.workouts) { workout in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(workout.name)
                            .font(.headline)

                        Text("\(workout.exercises.count) exercises")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}


#Preview {
    WorkoutsView()
}
