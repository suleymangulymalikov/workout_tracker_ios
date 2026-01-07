import SwiftUI
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var workoutName: String = "" {
        didSet { saveCurrentWorkout() }
    }

    @Published var exercises: [WorkoutExercise] = [] {
        didSet { saveCurrentWorkout() }
    }

    private let storageKey = "current_workout"

    init() {
        loadCurrentWorkout()
    }

    func addExercise(
        exercise: ExerciseItem,
        sets: Int,
        repsOrTime: Int
    ) {
        let workoutExercise = WorkoutExercise(
            exercise: exercise,
            sets: sets,
            repsOrTime: repsOrTime
        )
        exercises.append(workoutExercise)
    }

    private func saveCurrentWorkout() {
        let workout = Workout(name: workoutName, exercises: exercises)
        if let data = try? JSONEncoder().encode(workout) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadCurrentWorkout() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let workout = try? JSONDecoder().decode(Workout.self, from: data)
        else { return }

        workoutName = workout.name
        exercises = workout.exercises
    }
}
