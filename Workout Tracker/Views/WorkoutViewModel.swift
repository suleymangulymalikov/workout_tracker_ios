import SwiftUI
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var workoutName: String = ""
    @Published var exercises: [WorkoutExercise] = []
    @Published var completedWorkouts: [CompletedWorkout] = []


    private let storageKey = "saved_workouts"
    private let completedStorageKey = "completed_workouts"


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
    
    
    // Call this when user finishes a workout
    func markWorkoutCompleted(workout: Workout) {
        let completed = CompletedWorkout(
            workoutName: workout.name,
            dateCompleted: Date(),
            exercisesCompleted: workout.exercises.count
        )
        completedWorkouts.append(completed)
        saveCompleted()
    }

    // MARK: - Persistence

    private func saveCompleted() {
        if let data = try? JSONEncoder().encode(completedWorkouts) {
            UserDefaults.standard.set(data, forKey: completedStorageKey)
        }
    }
    
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
        // Load saved workouts
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Workout].self, from: data) {
            workouts = decoded
        }

        // Load completed workouts
        if let data = UserDefaults.standard.data(forKey: completedStorageKey),
           let decodedCompleted = try? JSONDecoder().decode([CompletedWorkout].self, from: data) {
            completedWorkouts = decodedCompleted
        }
    }
}
