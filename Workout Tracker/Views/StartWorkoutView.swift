import SwiftUI

struct StartWorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        List {
            ForEach(viewModel.workouts) { workout in
                NavigationLink(destination: ActiveWorkoutView(workout: workout)) {
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .font(.headline)
                        Text("\(workout.exercises.count) exercises")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Start Workout")
    }
}
