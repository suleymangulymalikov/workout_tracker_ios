import SwiftUI
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var workoutName: String = ""
    @Published var exercises: [WorkoutExercise] = []

    private let storageKey = "saved_workouts"

    init() {
        load()
    }

    // MARK: - Workout building

    func addExercise(
        exercise: ExerciseItem,
        sets: Int,
        reps: Int
    ) {
        let workoutExercise = WorkoutExercise(
            exercise: exercise,
            sets: sets,
            reps: reps
        )
        exercises.append(workoutExercise)
    }

    func saveWorkout() {
        guard !workoutName.isEmpty, !exercises.isEmpty else { return }

        let workout = Workout(
            name: workoutName,
            exercises: exercises
        )

        workouts.append(workout)

        // Reset builder
        workoutName = ""
        exercises = []

        save()
    }

    // MARK: - Persistence

    private func save() {
        if let data = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([Workout].self, from: data)
        else { return }

        workouts = decoded
    }
}
