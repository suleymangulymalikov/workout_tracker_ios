import SwiftUI

struct ActiveWorkoutView: View {
    let workout: Workout
    @State private var showFinishAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text(workout.name)
                .font(.largeTitle)
                .bold()
                .padding()

            List {
                ForEach(workout.exercises) { workoutExercise in
                    VStack(alignment: .leading) {
                        Text(workoutExercise.exercise.name)
                            .font(.headline)
                        Text("Sets: \(workoutExercise.sets), Reps: \(workoutExercise.reps)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }

            Button("Finish Workout") {
                showFinishAlert = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(isPresented: $showFinishAlert) {
                Alert(
                    title: Text("Finish Workout"),
                    message: Text("Are you sure you want to finish this workout?"),
                    primaryButton: .default(Text("Yes"), action: {
                        // For now, just dismiss. Could add completion logic later.
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle("Workout")
    }
}
