import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel

    var todayCompletedWorkouts: [CompletedWorkout] {
        let calendar = Calendar.current
        return viewModel.completedWorkouts.filter { calendar.isDateInToday($0.dateCompleted) }
    }

    var totalExercisesToday: Int {
        todayCompletedWorkouts.reduce(0) { $0 + $1.exercisesCompleted }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Progress")
                    .font(.largeTitle)
                    .bold()
                
                Text("Workouts Completed Today: \(todayCompletedWorkouts.count)")
                    .font(.title2)
                
                Text("Exercises Completed Today: \(totalExercisesToday)")
                    .font(.title2)
                
                Divider()
                
                if todayCompletedWorkouts.isEmpty {
                    Text("No workouts completed today.")
                        .foregroundColor(.gray)
                } else {
                    List(todayCompletedWorkouts) { completed in
                        VStack(alignment: .leading) {
                            Text(completed.workoutName)
                                .font(.headline)
                            Text("Exercises: \(completed.exercisesCompleted)")
                            Text("Completed at: \(completed.dateCompleted.formatted(date: .omitted, time: .shortened))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .frame(height: 300)
                }
            }
            .padding()
        }
        .navigationTitle("Progress")
    }
}
